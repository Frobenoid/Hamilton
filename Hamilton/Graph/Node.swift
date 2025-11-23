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
    
    // UI Related (move this)
    var label: String = ""
    var isSelected: Bool = false
    var isDragging: Bool = false
    var offset: CGSize = .zero
    
    public func execute() throws {}

    /// Used inside the evaluation loop. Returns the current value of the
    /// output socket at the specified location.
    public func getUntypedOutput(at output: SocketID) throws(GraphError) -> Any?
    {
        if output < outputs.count {
            return outputs[output].untypedCurrentValue()
        } else {
            throw GraphError.outOfRangeOutput(output: output)
        }
    }

    public func setUntypedInput(at input: SocketID, to value: Any)
        throws(GraphError)
    {
        if input < inputs.count {
            try inputs[input].setUntypedCurrentValue(to: value)
        } else {
            throw GraphError.outOfRangeInput(input: input)
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
