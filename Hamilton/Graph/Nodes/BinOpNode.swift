//
//  BinOpNode.swift
//  Hamilton
//
//  Created by Milton Montiel on 18/11/25.
//

import Foundation

struct BinOpNode: NodeType {
    var label: String = "Binary Operation"

    var description: String = "A binary operation"

    enum Op {
        case sum, mul, sub, div
    }

    func exec(_ p: inout NodeParameters) throws {
        let a: Float = try p.getInput(at: 0)
        let b: Float = try p.getInput(at: 1)
        try p.setOutput(at: 0, to: a + b)
    }

    func declare(_ b: inout ParameterBuilder) {

        b.addInput(
            Input<Float>()
                .withDefaultValue(0)
                .withLabel("Value")
                .asUserModifiable()
        )

        b.addInput(
            Input<Float>()
                .withDefaultValue(0)
                .withLabel("Value")
                .asUserModifiable()
        )

        b.addOutput(
            Output<Float>()
                .withDefaultValue(0)
                .withLabel("Value")
        )
    }

}
