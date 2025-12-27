//
//  Node.swift
//  Hamilton
//
//  Created by Milton Montiel on 15/11/25.
//

import Foundation

//@Observable
//class Node {
//    var inputs: [any Socket] = []
//    var outputs: [any Socket] = []
//    var id: Int = -1
//
//    // UI Related (move this)
//    var label: String = ""
//    var initialPosition: CGPoint = .zero
//
//    public func execute() throws {}
//
//    /// Used inside the evaluation loop. Returns the current value of the
//    /// output socket at the specified location.
//    public func getUntypedOutput(at output: SocketID) throws(GraphError) -> Any?
//    {
//        if output < outputs.count {
//            return outputs[output].untypedCurrentValue()
//        } else {
//            throw GraphError.outOfRangeOutput(output: output)
//        }
//    }
//
//    public func setUntypedInput(at input: SocketID, to value: Any)
//        throws(GraphError)
//    {
//        if input < inputs.count {
//            try inputs[input].setUntypedCurrentValue(to: value)
//        } else {
//            throw GraphError.outOfRangeInput(input: input)
//        }
//    }
//
//    /// Modifies the node ID and each of its sockets parent ID.
//    public func setID(to newID: NodeID) {
//        id = newID
//
//        inputs.indices.forEach { i in
//            inputs[i].parentID = newID
//        }
//
//        outputs.indices.forEach { i in
//            outputs[i].parentID = newID
//        }
//    }
//
//    /// Adds an input to the node, wrapping a desired type.
//    public func addInput<T>(_ input: Input<T>) {
//        input.id = inputs.count
//        inputs.append(input)
//    }
//
//    /// Adds an output to the node, wrapping a desired type.
//    public func addOutput<T>(_ output: Output<T>) {
//        output.id = outputs.count
//        outputs.append(output)
//    }
//}

/// Contains information about the actual node, including:
/// 1. UI Information.
/// 2. Pointers to the node type.
struct Node {
    // Index in parent graph.
    var idInGraph: Int = -1
    var id: Int {
        get {
            idInGraph
        }
        set {
            inputs.indices.forEach { i in
                inputs[i].parentID = newValue
            }

            outputs.indices.forEach { i in
                outputs[i].parentID = newValue
            }
        }
    }

    // UI Information.
    var initialPosition: CGPoint = .zero
    var isSelected: Bool = false

    // Type information.
    var type: any NodeType = NullNode()

    // Sockets
    var inputs: [any Socket] = []
    var outputs: [any Socket] = []
}

extension Node {
    var label: String {
        type.label
    }

    var description: String {
        type.description
    }

    var declare: (inout ParameterBuilder) -> Void {
        type.declare
    }

    var execute: (NodeParameters) throws -> Void {
        type.exec
    }
}

protocol NodeType {
    var label: String { get }
    var description: String { get }

    func exec(_ p: NodeParameters) throws
    func declare(_ b: inout ParameterBuilder)
}

struct Test: NodeType {
    var label: String = "Test"
    var description: String = "A test node."

    func exec(_ p: NodeParameters) throws {
        var t: Int = try p.getOutput(at: 0)
        t += 1
    }

    func declare(_ b: inout ParameterBuilder) {
        b.addInput(
            Input<Int>()
                .withLabel("Test")
        )
    }
}

struct NodeParameters {
    var node: Node

    var inputs: [any Socket] {
        node.inputs
    }

    var outputs: [any Socket] {
        node.outputs
    }

    public func getOutput<T>(at output: SocketID) throws(GraphError)
        -> T
    {
        if output < outputs.count {
            guard let out = outputs[output].defaultValue as? T else {
                throw GraphError.imposibleCasting(
                    from: T.self,
                    to: T.self
                )
            }
            return out
        } else {
            throw GraphError.outOfRangeOutput(output: output)
        }
    }

    mutating public func setInput<T>(at input: SocketID, to value: T)
        throws(GraphError)
    {
        if input < inputs.count {
            // TODO: Make sure we can cast!
            try inputs[input].setUntypedCurrentValue(to: value)
        } else {
            throw GraphError.outOfRangeInput(input: input)
        }
    }

}

struct ParameterBuilder {
    private var inputs: [any Socket] = []
    private var outputs: [any Socket] = []

    mutating func addInput<T>(_ input: Input<T>) {
        input.id = inputs.count
        inputs.append(input)
    }

    mutating func addOutput<T>(_ output: Output<T>) {
        output.id = outputs.count
        outputs.append(output)
    }

    func build(node: inout Node) {
        node.inputs = inputs
        node.outputs = outputs
    }
}
