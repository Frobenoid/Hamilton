//
//  Graph.swift
//  Hamilton
//
//  Created by Milton Montiel on 15/11/25.
//

import Foundation

class Graph {
    public var nodes: [Node] = []
    private(set) var edges: [Link] = []

    public func addNode(_ node: Node) {
        node.id = nodes.count
        nodes.append(node)
    }

    /// Deletes a node and all of its incident edges.
    public func deleteNode(withID id: NodeID) {
        // First we remove all incoming and
        // outgoing links.
        edges.filter({
            $0.destinationNode == id || $0.sourceNode == id
        })
        .forEach {
            disconnect($0.id)
        }

        if id < nodes.count - 1 {
            let prevId = nodes.count - 1

            nodes.swapAt(id, prevId)

            // Update swapped node id.
            nodes[id].id = id

            // Update the origin of all connections that
            // were previously linked to the node at the top
            // of the stack.

            // Update outgoing.
            edges
                .indices
                .filter { edges[$0].sourceNode == prevId }
                .forEach {
                    edges[$0].sourceNode = id
                }

            // Update incoming.
            edges
                .indices
                .filter { edges[$0].destinationNode == prevId }
                .forEach {
                    edges[$0].destinationNode = id
                }

        }

        nodes.removeLast()
    }

    /// Connects two nodes as specified by the provided ``Link``.
    public func connect(_ link: Link) {
        link.id = edges.count
        edges.append(link)
    }

    /// Deletes the provided link.
    public func disconnect(_ link: LinkID) {
        // Restore values to default.
        let edge = edges[link]

        nodes[edge.sourceNode]
            .outputs[edge.sourceSocket]
            .restoreToDefaultValue()

        nodes[edge.destinationNode]
            .inputs[edge.destinationSocket]
            .restoreToDefaultValue()

        // Delete link.
        edges.swapAt(link, edges.count - 1)
        edges[link].id = link
        edges.removeLast()

    }

}
