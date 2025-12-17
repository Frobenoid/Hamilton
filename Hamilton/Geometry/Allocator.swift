//
//  Allocator.swift
//  Hamilton
//
//  Created by Milton Montiel on 15/12/25.
//

import Foundation
import MetalKit

extension MTKMeshBufferAllocator {
    func newVertexBuffer(from vertices: [Vertex]) -> MDLMeshBuffer {
        self.newBuffer(
            with:
                Data(
                    bytes: vertices,
                    count: vertices.count * MemoryLayout<Vertex>.stride
                ),
            type: .vertex
        )
    }

    func newIndexBuffer(from indices: [UInt32]) -> MDLMeshBuffer {
        self.newBuffer(
            with: Data(
                bytes: indices,
                count: indices.count * MemoryLayout<UInt32>.stride
            ),
            type: .index
        )
    }
}
