//
//  Model.swift
//  Hamilton
//
//  Created by Milton Montiel on 25/11/25.
//

import Foundation
import MetalKit
import ModelIO

struct Model: Transformable {
    var transform = Transform()
    
    var name: String = "Untitled Model"
    var meshes: [Mesh]

    init(
        name: String,
        type: PrimitiveType,
        extent: vector_float3 = .one,
        segments: vector_uint3 = .one,
        geometryType: MDLGeometryType = .triangles
    ) {

        let mdlMesh = Self.createMesh(
            primitiveType: type,
            extent: extent,
            segments: segments,
            geometryType: geometryType,
        )
        mdlMesh.vertexDescriptor = MDLVertexDescriptor.defaultLayout

        let mtkMesh = try! MTKMesh(mesh: mdlMesh, device: Renderer.device)
        let mesh = Mesh(mdlMesh: mdlMesh, mtkMesh: mtkMesh)

        self.meshes = [mesh]
        self.transform.scale = 0.05
    }

    mutating func subdivide(subdivisionLevels: Int) {

        if let new = MDLMesh.newSubdividedMesh(
            meshes.first!.mesh,
            submeshIndex: 0,
            subdivisionLevels: subdivisionLevels
        ) {
            new.vertexDescriptor = MDLVertexDescriptor.defaultLayout
            let mtkMesh = try! MTKMesh(mesh: new, device: Renderer.device)
            let mesh = Mesh(mdlMesh: new, mtkMesh: mtkMesh)

            self.meshes = [mesh]

        } else {
            return
        }

    }

    static func createMesh(
        primitiveType: PrimitiveType,
        extent: vector_float3 = .one,
        segments: vector_uint3 = .one,
        geometryType: MDLGeometryType = .triangles
    ) -> MDLMesh {
        let allocator = MTKMeshBufferAllocator(device: Renderer.device)

        switch primitiveType {
        case .box:
            return MDLMesh(
                boxWithExtent: extent,
                segments: segments,
                inwardNormals: false,
                geometryType: geometryType,
                allocator: allocator
            )
        case .cone:
            return MDLMesh(
                coneWithExtent: extent,
                segments: [segments.x, segments.y],
                inwardNormals: false,
                cap: false,
                geometryType: geometryType,
                allocator: allocator
            )
        case .cylinder:
            return MDLMesh(
                cylinderWithExtent: extent,
                segments: [segments.x, segments.y],
                inwardNormals: false,
                topCap: false,
                bottomCap: false,
                geometryType: geometryType,
                allocator: allocator
            )
        case .sphere:
            return MDLMesh(
                sphereWithExtent: extent,
                segments: [segments.x, segments.y],
                inwardNormals: false,
                geometryType: geometryType,
                allocator: allocator
            )
        case .capsule:
            return MDLMesh(
                capsuleWithExtent: extent,
                cylinderSegments: [segments.x, segments.y],
                hemisphereSegments: 1,
                inwardNormals: false,
                geometryType: geometryType,
                allocator: allocator
            )
        }
    }
}


extension Model {
    func render(
        encoder: MTLRenderCommandEncoder,
        uniforms: Uniforms,
        primitiveType: MTLPrimitiveType = .triangle
    ) {

        var unif = uniforms

        unif.modelMatrix = transform.modelMatrix
        
        print(unif.modelMatrix)
        encoder.setVertexBytes(
            &unif,
            length: MemoryLayout<Uniforms>.stride,
            // TODO: Remove magic number.
            index: 1
        )

        for mesh in meshes {
            for (index, vertexBuffer) in mesh.vertexBuffers.enumerated() {
                encoder.setVertexBuffer(vertexBuffer, offset: 0, index: index)
            }

            for submesh in mesh.submeshes {
                encoder.drawIndexedPrimitives(
                    type: primitiveType,
                    indexCount: submesh.indexCount,
                    indexType: submesh.indexType,
                    indexBuffer: submesh.indexBuffer,
                    indexBufferOffset: submesh.indexBufferOffset
                )
            }
        }

    }
}
