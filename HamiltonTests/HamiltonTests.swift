//
//  HamiltonTests.swift
//  HamiltonTests
//
//  Created by Milton Montiel on 15/11/25.
//

import Testing

@testable import Hamilton

struct HamiltonTests {
    @Test func graphConstruction() {
        var graph = Graph()
        var builder = NodeBuilder()

        graph.addNode(builder.build(ofType: ConstantNode()))
        graph.addNode(builder.build(ofType: ConstantNode()))
        graph.addNode(builder.build(ofType: BinOpNode()))
        graph.addNode(builder.build(ofType: BinOpNode()))

        // 0 -> 2
        graph.connect(
            sourceNode: 0,
            sourceSocket: 0,
            destinationNode: 2,
            destinationSocket: 0
        )

        // 1 -> 2
        graph.connect(
            sourceNode: 1,
            sourceSocket: 0,
            destinationNode: 2,
            destinationSocket: 1
        )

        // 2 -> 3
        graph.connect(
            sourceNode: 2,
            sourceSocket: 0,
            destinationNode: 3,
            destinationSocket: 0
        )

        // 1 -> 3
        graph.connect(
            sourceNode: 1,
            sourceSocket: 0,
            destinationNode: 3,
            destinationSocket: 1
        )

        #expect(graph.nodes.count == 4)
        #expect(graph.edges.count == 4)

        graph.deleteNode(withID: 2)

        #expect(graph.edges.count == 1)
        #expect(graph.edges[0].id == 0)

        #expect(graph.nodes[2].id == 2)
    }

    @Test func graphEvaluation() {
        var graph = Graph()
        let evaluator = Evaluator(graph: graph)
        var builder = NodeBuilder()

        graph.addNode(builder.build(ofType: ConstantNode()))
        graph.addNode(builder.build(ofType: ConstantNode()))
        graph.addNode(builder.build(ofType: BinOpNode()))
        graph.addNode(builder.build(ofType: BinOpNode()))

        // 0 -> 2
        graph.connect(
            sourceNode: 0,
            sourceSocket: 0,
            destinationNode: 2,
            destinationSocket: 0
        )

        // 1 -> 2
        graph.connect(
            sourceNode: 1,
            sourceSocket: 0,
            destinationNode: 2,
            destinationSocket: 1
        )

        // 2 -> 3
        graph.connect(
            sourceNode: 2,
            sourceSocket: 0,
            destinationNode: 3,
            destinationSocket: 0
        )

        // 1 -> 3
        graph.connect(
            sourceNode: 1,
            sourceSocket: 0,
            destinationNode: 3,
            destinationSocket: 1
        )

        try! evaluator.evaluate()

        #expect(graph.nodes[3].outputs[0].currentValue as! Float == 3.0)

        graph.deleteNode(withID: 2)

        try! evaluator.evaluate()

        #expect(graph.nodes[2].outputs[0].currentValue as! Float == 1.0)

        graph.disconnect(0)

        try! evaluator.evaluate()

        #expect(graph.nodes[2].outputs[0].currentValue as! Float == 0)
    }

    @Test func cycleDetection() {
        let graph = Graph()
        let evaluator = Evaluator(graph: graph)
        var builder = NodeBuilder()

        graph.addNode(builder.build(ofType: BinOpNode()))
        graph.addNode(builder.build(ofType: BinOpNode()))

        graph.connect(
            sourceNode: 0,
            sourceSocket: 0,
            destinationNode: 1,
            destinationSocket: 0
        )

        graph.connect(
            sourceNode: 1,
            sourceSocket: 0,
            destinationNode: 0,
            destinationSocket: 0
        )

        #expect(
            throws: (any Error).self,
            "Contains a cycle.",
            performing: {
                try evaluator.evaluate()
            }
        )
    }

    @Test func nodeConstruction() {
        var builder = NodeBuilder()
        let output = builder.build(ofType: OutputNode())
        let null = builder.build(ofType: NullNode())

        #expect(output.inputs.count == 1)
        #expect(output.outputs.count == 0)

        #expect(null.inputs.count == 0)
        #expect(null.outputs.count == 0)
    }

    @Test func evaluator() {
        var builder = NodeBuilder()
        let a = builder.build(ofType: ConstantNode())
        let b = builder.build(ofType: ConstantNode())
        let c = builder.build(ofType: BinOpNode())

        let g = Graph()

        g.addNode(a)
        g.addNode(b)
        g.addNode(c)

        g.connect(
            sourceNode: 0,
            sourceSocket: 0,
            destinationNode: 2,
            destinationSocket: 0
        )

        g.connect(
            sourceNode: 1,
            sourceSocket: 0,
            destinationNode: 2,
            destinationSocket: 1
        )

        try! Evaluator(graph: g).evaluate()

        #expect(g.nodes[2].outputs[0].currentValue as! Float == 2.0)

    }
}
