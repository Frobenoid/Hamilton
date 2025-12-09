//
//  WaveNode.swift
//  Hamilton
//
//  Created by Milton Montiel on 08/12/25.
//

import Foundation

class WaveNode : Node {
    override init() {
        super.init()
        label = "Wave"
        addInput(
            Input<Float>()
                .withLabel("Input")
                .withDefaultValue(0.0)
        )
        
        addOutput(
            Output<Float>()
                .withLabel("Output")
                .withDefaultValue(0.0)
        )
    }
    
    override func execute() throws {
        let input = inputs[0].untypedCurrentValue() as! Float
        
        try outputs[0].setUntypedCurrentValue(to: sin(input))
    }
}
