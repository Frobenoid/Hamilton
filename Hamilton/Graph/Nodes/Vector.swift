//
//  Vector.swift
//  Hamilton
//
//  Created by Milton Montiel on 27/11/25.
//

import Foundation
import simd

class VectorNode: Node {
    override init() {
        super.init()
        label = "Vector"

        addInput(
            Input<Float>()
                .withDefaultValue(1.0)
                .withLabel("X")
                .asUserModifiable()
        )

        addInput(
            Input<Float>()
                .withDefaultValue(1.0)
                .withLabel("Y")
                .asUserModifiable()
        )

        addInput(
            Input<Float>()
                .withDefaultValue(1.0)
                .withLabel("Z")
                .asUserModifiable()
        )

        addOutput(
            Output<vector_float3>()
                .withDefaultValue(.one)
                .withLabel("Vector")
        )
    }

    override func execute() throws {
        let x = inputs[0].untypedCurrentValue() as! Float
        let y = inputs[1].untypedCurrentValue() as! Float
        let z = inputs[2].untypedCurrentValue() as! Float

        let output = vector_float3(x: x, y: y, z: z)

        try outputs[0].setUntypedCurrentValue(to: output)
    }
}

class UIntVectorNode: Node {
    override init() {
        super.init()
        label = "UInt Vector"

        addInput(
            Input<Float>()
                .withDefaultValue(1)
                .withLabel("X")
                .asUserModifiable()
        )

        addInput(
            Input<Float>()
                .withDefaultValue(1)
                .withLabel("Y")
                .asUserModifiable()
        )

        addInput(
            Input<Float>()
                .withDefaultValue(1)
                .withLabel("Z")
                .asUserModifiable()
        )

        addOutput(
            Input<SIMD3<UInt32>>()
                .withDefaultValue(.zero)
                .withLabel("Vector")
        )
    }

    override func execute() throws {
        let x = inputs[0].untypedCurrentValue() as! Float
        let y = inputs[1].untypedCurrentValue() as! Float
        let z = inputs[2].untypedCurrentValue() as! Float
        
        let output = vector_uint3(
            x: UInt32(
                x > 0 ? x : 0
            ),
            y: UInt32(
                y > 0 ? y : 0
            ),
            z: UInt32(
                z > 0 ? z : 0
            )
        )

        try outputs[0].setUntypedCurrentValue(to: output)
    }
}
