//
//  Node.swift
//  Hamilton
//
//  Created by Milton Montiel on 15/11/25.
//

import Foundation

class Node {
    var inputs: [any Socket] = []
    var outputs: [any Socket] = []
    var id: Int = -1

    func execute() throws {}

    /// Used inside the evaluation loop. Returns the current value of the
    /// output socket at the specified location.
    public func getUntypedOutput(at output: SocketID) throws(GraphError) -> Any?
    {
        if output < outputs.count {
            return outputs[output].currentValue
        } else {
            throw GraphError.outOfRangeOutput(output: output)
        }
    }

    /// Adds an input to the node, wrapping a desired type.
    public func addInput<T>(_ input: Input<T>) {
        input.id = inputs.count
        inputs.append(input)
    }

    /// Adds an output to the node, wrapping a desired type.
    public func addOutput<T>(_ output: Output<T>) {
        output.id = outputs.count
        outputs.append(output)
    }
}
