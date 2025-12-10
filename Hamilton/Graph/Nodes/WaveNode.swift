//
//  WaveNode.swift
//  Hamilton
//
//  Created by Milton Montiel on 08/12/25.
//

import Foundation

class WaveNode: Node {
    override init() {
        super.init()
        label = "Wave"
        addInput(
            Input<Float>()
                .withLabel("Input")
                .withDefaultValue(0.0)
        )

        addInput(
            Input<Float>()
                .withLabel("Frequency")
                .withDefaultValue(1.0)
                .asUserModifiable()
        )

        addInput(
            Input<Float>()
                .withLabel("Amplitude")
                .withDefaultValue(1.0)
                .asUserModifiable()
        )

        addInput(
            Input<Bool>()
                .withLabel("Y-Offset")
                .withDefaultValue(true)
                .asUserModifiable()
        )

        addOutput(
            Output<Float>()
                .withLabel("Output")
                .withDefaultValue(0.0)
        )
    }

    override func execute() throws {
        let input = inputs[0].untypedCurrentValue() as! Float
        let frequency = inputs[1].untypedCurrentValue() as! Float
        let amplitude = inputs[2].untypedCurrentValue() as! Float
        let shouldYOffset = inputs[3].untypedCurrentValue() as! Bool

        try outputs[0].setUntypedCurrentValue(
            to:
                amplitude * sin(input * frequency)
                + (shouldYOffset ? amplitude : 0)
        )
    }
}
