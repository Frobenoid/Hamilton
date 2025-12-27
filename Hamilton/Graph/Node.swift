//
//  Node.swift
//  Hamilton
//
//  Created by Milton Montiel on 15/11/25.
//

import Foundation

protocol NodeType {
    var label: String { get }
    var description: String { get }

    func exec(_ p: NodeParameters) throws
    func declare(_ b: inout ParameterBuilder)
}

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

    mutating func build(node: inout Node) {
        node.inputs = inputs
        node.outputs = outputs

        inputs = []
        outputs = []
    }
}

struct NodeBuilder {
    var p: ParameterBuilder = .init()

    mutating func build(ofType: any NodeType) -> Node {
        var node = Node()
        
        node.type = ofType
        node.declare(&p)
        p.build(node: &node)
        
        return node
    }
}
