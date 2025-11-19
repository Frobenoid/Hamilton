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

    public func getUntypedOutput(at output: SocketID) throws(GraphError) -> Any?
    {
        if output < outputs.count {
            return outputs[output].currentValue
        } else {
            throw GraphError.outOfRangeOutput(output: output)
        }
    }

    public func addInput<T>(_ input: Input<T>) {
        input.id = inputs.count
        inputs.append(input)
    }

    public func addOutput<T>(_ output: Output<T>) {
        output.id = outputs.count
        outputs.append(output)
    }
}
