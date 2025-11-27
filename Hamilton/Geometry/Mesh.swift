//
//  Mesh.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import Foundation
import MetalKit

//struct Mesh {
//    public var vertices: [Vertex] = []
//    public var indices: [UInt32] = []
//
//}
//
//extension Mesh {
//    static let empty = Mesh()
//
//    static let cube: Mesh = {
//        var mesh = Mesh()
//
//        return mesh
//    }()
//
//    static let triangle: Mesh = {
//        var mesh = Mesh()
//
//        mesh.vertices = [
//            Vertex(position: [0.0, 0.0, 0.0]),
//            Vertex(position: [0.0, 0.1, 0.0]),
//            Vertex(position: [0.0, 0.0, 0.1]),
//        ]
//
//        mesh.indices = [
//            0, 1, 2,
//        ]
//
//        return mesh
//    }()
//}

struct Mesh {
    var vertexBuffers: [MTLBuffer]
    var submeshes: [Submesh]
}

extension Mesh {
    init(mdlMesh: MDLMesh, mtkMesh: MTKMesh) {
        var vertexBuffers: [MTLBuffer] = []
        for mtkMeshBuffer in mtkMesh.vertexBuffers {
            vertexBuffers.append(mtkMeshBuffer.buffer)
        }
        self.vertexBuffers = vertexBuffers
        submeshes = zip(mdlMesh.submeshes!, mtkMesh.submeshes).map { mesh in
            Submesh(mdlSubmesh: mesh.0 as! MDLSubmesh, mtkSubmesh: mesh.1)
        }
    }
}
