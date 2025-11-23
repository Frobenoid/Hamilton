//
//  BinOpNode.swift
//  Hamilton
//
//  Created by Milton Montiel on 18/11/25.
//

import Foundation

class BinOpNode: Node {

    enum Operation {
        case sum, mul, sub, div
    }

    init(variant: Operation = .sum) {
        super.init()
        label = "Binary Operation"

        addInput(
            Input<Float>()
                .withDefaultValue(0)
        )

        addInput(
            Input<Float>()
                .withDefaultValue(0)
        )

        addOutput(
            Output<Float>()
                .withDefaultValue(0)
        )
    }

    override func execute() throws {
        let a = self.inputs[0].currentValue as! Float
        let b = self.inputs[1].currentValue as! Float
        try self.outputs[0].setUntypedCurrentValue(to: a + b)
    }
}
