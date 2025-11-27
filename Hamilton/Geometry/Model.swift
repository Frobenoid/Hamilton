//
//  Model.swift
//  Hamilton
//
//  Created by Milton Montiel on 25/11/25.
//

import Foundation
import MetalKit

class Model {
    var name: String = "Untitled Model"
    var meshes: [Mesh]

    init(
        name: String,
        type: PrimitiveType,
        extent: vector_float3 = .one,
        geometryType: MDLGeometryType = .triangles
    ) {
        self.name = name
        let mdlMesh = Self.createMesh(
            primitiveType: type,
            extent: extent,
            geometryType: geometryType
        )
        mdlMesh.vertexDescriptor = MDLVertexDescriptor.defaultLayout

        let mtkMesh = try! MTKMesh(mesh: mdlMesh, device: Renderer.device)
        let mesh = Mesh(mdlMesh: mdlMesh, mtkMesh: mtkMesh)

        self.meshes = [mesh]
    }

    static func createMesh(
        primitiveType: PrimitiveType,
        extent: vector_float3 = .one,
        geometryType: MDLGeometryType = .triangles
    ) -> MDLMesh {
        let allocator = MTKMeshBufferAllocator(device: Renderer.device)

        switch primitiveType {
        case .box:
            return MDLMesh(
                boxWithExtent: extent,
                segments: [1, 1, 1],
                inwardNormals: false,
                geometryType: geometryType,
                allocator: allocator
            )
        case .cone:
            return MDLMesh(
                coneWithExtent: extent,
                segments: [1, 1],
                inwardNormals: false,
                cap: false,
                geometryType: geometryType,
                allocator: allocator
            )
        case .cylinder:
            return MDLMesh(
                cylinderWithExtent: extent,
                segments: [10, 10],
                inwardNormals: false,
                topCap: false,
                bottomCap: false,
                geometryType: geometryType,
                allocator: allocator
            )
        case .sphere:
            return MDLMesh(
                sphereWithExtent: extent,
                segments: [10, 10],
                inwardNormals: false,
                geometryType: geometryType,
                allocator: allocator
            )
        case .capsule:
            return MDLMesh(
                capsuleWithExtent: extent,
                cylinderSegments: [5, 5],
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
        primitiveType: MTLPrimitiveType = .triangle
    ) {

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
