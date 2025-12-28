//
//  Evaluator.swift
//  Hamilton
//
//  Created by Milton Montiel on 15/11/25.
//

class Evaluator {
    var graph: Graph
    private var colors: [NodeID: Color] = [:]
    private var executionOrder: [NodeID] = []

    init(graph: Graph) {
        self.graph = graph
    }

    func evaluate() throws {
        try validateGraph()

        executionOrder
            .reversed()
            .forEach { node in
                execute(node)
                propagateValues(for: node)
            }

    }
}

extension Evaluator {
    private enum Color {
        case white, gray, black
    }

    private func validateGraph() throws {
        executionOrder = []
        try dfs()
    }

    private func dfs() throws {
        colors = Dictionary(
            uniqueKeysWithValues: graph.nodes.indices.map { ($0, .white) }
        )

        // TODO: This should start with the distinguished node.
        try graph.nodes.indices.forEach { nodeId in
            if colors[nodeId] == .white {
                try visit(nodeId)
            }
        }
    }

    private func visit(_ node: NodeID) throws {
        // Mark as discovered
        colors[node] = .gray

        let neighbors = graph.edges.filter { $0.sourceNode == node }

        // Check if there are directed cycles.
        if (neighbors.contains { colors[$0.destinationNode] == .gray }) {
            throw GraphError.containsDirectedCycle(graph: graph, node: node)
        }

        // Visit unexplored nodes.
        try neighbors.filter { colors[$0.destinationNode] == .white }.forEach {
            try visit($0.destinationNode)
        }

        // Mark as explored
        executionOrder.append(node)
        colors[node] = .black

    }

    private func propagateValues(for node: NodeID) {
        graph
            .edges
            // Get neighbors of current node.
            .filter { $0.sourceNode == node }
            // Propagate values for each neighbor.
            .forEach { edge in

                if let output =
                    graph
                    .nodes[edge.sourceNode]
                    .outputs[edge.sourceSocket]
                    .currentValue as Any?
                {
                    try?
                        graph
                        .nodes[edge.destinationNode]
                        .inputs[edge.destinationSocket]
                        .setUntypedCurrentValue(to: output)
                } else {
                    return
                }
            }

    }

    /// ``node`` should always be within range.
    private func execute(_ node: NodeID) {
        var params = NodeParameters(node: graph.nodes[node])
        debugPrint(params.inputs)
        try! graph.nodes[node].execute(&params)
        debugPrint(params)
    }

}
