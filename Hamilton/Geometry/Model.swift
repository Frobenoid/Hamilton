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

    init(name: String, type: PrimitiveType) {
        self.name = name
        let mdlMesh = Self.createMesh(primitiveType: type)
        mdlMesh.vertexDescriptor = MDLVertexDescriptor.defaultLayout

        let mtkMesh = try! MTKMesh(mesh: mdlMesh, device: Renderer.device)
        let mesh = Mesh(mdlMesh: mdlMesh, mtkMesh: mtkMesh)

        self.meshes = [mesh]
    }

    static func createMesh(primitiveType: PrimitiveType) -> MDLMesh {
        let allocator = MTKMeshBufferAllocator(device: Renderer.device)

        switch primitiveType {
        case .box:
            return MDLMesh(
                boxWithExtent: [0.5, 0.5, 0.5],
                segments: [1, 1, 1],
                inwardNormals: false,
                geometryType: .triangles,
                allocator: allocator
            )
        case .cone:
            return MDLMesh(
                coneWithExtent: [0.5, 0.5, 0.5],
                segments: [1, 1],
                inwardNormals: false,
                cap: false,
                geometryType: .triangles,
                allocator: allocator
            )
        default:
            return MDLMesh(
                sphereWithExtent: [0.5, 0.5, 0.5],
                segments: [10, 10],
                inwardNormals: false,
                geometryType: .triangles,
                allocator: allocator
            )

        }
    }
}

extension Model {
    func render(
        encoder: MTLRenderCommandEncoder,
        primitiveType: MTLPrimitiveType = .lineStrip
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
