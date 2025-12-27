//
//  Graph.swift
//  Hamilton
//
//  Created by Milton Montiel on 15/11/25.
//

import Foundation

/// This graph object manages connections between nodes and
/// their sockets.
@Observable
class Graph {
    public var nodes: [Node] = []
    private(set) var edges: [Edge] = []

    /// Inserts a node to the graph.
    public func addNode(_ node: Node) {
        var node = node
        node.id = nodes.count
        nodes.append(node)
    }

    /// Deletes a node and all of its incident edges.
    public func deleteNode(withID id: NodeID) {
        // First we remove all incoming and
        // outgoing edges.
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
            //            nodes[id].setID(to: id)
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

    /// Connects two nodes.
    public func connect(
        sourceNode: NodeID,
        sourceSocket: SocketID,
        destinationNode: NodeID,
        destinationSocket: SocketID
    ) {
        let edge = Edge(
            sourceNode: sourceNode,
            sourceSocket: sourceSocket,
            destinationNode: destinationNode,
            destinationSocket: destinationSocket
        )
        edge.id = edges.count
        edges.append(edge)

        // Mark destination socket as connected.
        nodes[edge.destinationNode]
            .inputs[edge.destinationSocket]
            .toggleConnection()
    }

    /// Deletes the provided edge.
    public func disconnect(_ edge: EdgeID) {
        // Restore values to default.
        let arrow = edges[edge]

        nodes[arrow.sourceNode]
            .outputs[arrow.sourceSocket]
            .restoreToDefaultValue()

        nodes[arrow.destinationNode]
            .inputs[arrow.destinationSocket]
            .restoreToDefaultValue()

        // Mark destination socket as receiving
        // no connection.
        nodes[arrow.destinationNode]
            .inputs[arrow.destinationSocket]
            .toggleConnection()

        // Delete edge.
        edges.swapAt(edge, edges.count - 1)
        edges[edge].id = edge
        edges.removeLast()

    }

}
