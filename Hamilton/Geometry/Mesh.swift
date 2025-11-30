//
//  Mesh.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import Foundation
import MetalKit

struct Mesh {
    var vertexBuffers: [MTLBuffer]
    var submeshes: [Submesh]
    var mesh: MDLMesh
}

extension Mesh {
    init(mdlMesh: MDLMesh, mtkMesh: MTKMesh) {
        mesh = mdlMesh

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
