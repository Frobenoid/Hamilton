//
//  Mesh.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import Foundation

struct Mesh {
    public var vertices: [Vertex] = []
    public var indices: [UInt32] = []

}

extension Mesh {
    static let empty = Mesh()

    static let cube: Mesh = {
        var mesh = Mesh()

        return mesh
    }()

    static let triangle: Mesh = {
        var mesh = Mesh()

        mesh.vertices = [
            Vertex(position: [0.0, 0.0, 0.0]),
            Vertex(position: [0.0, 0.1, 0.0]),
            Vertex(position: [0.0, 0.0, 0.1]),
        ]

        mesh.indices = [
            0, 1, 2,
        ]

        return mesh
    }()
}
