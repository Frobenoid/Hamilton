//
//  Primitive.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import Foundation

enum PrimitiveType: String, CaseIterable, Identifiable {
    var id: Self { self }
    case sphere
    case box
    case cylinder
    case cone
    case torus
}

class PrimitiveNode: Node {
    override init() {
        super.init()
        label = "Primitive"

        // Type of the primitive.
        addInput(
            Input<PrimitiveType>()
                .withDefaultValue(.box)
                .asUserModifiable()
                .withLabel("Primitive Type")
        )

        // Scale
        addInput(
            Input<Float>()
                .withDefaultValue(1.0)
                .withLabel("Scale")
                .asUserModifiable()
        )

        // Position
        addInput(
            Input<Float>()
                .withDefaultValue(0.0)
                .withLabel("X")
                .asUserModifiable()
        )
        addInput(
            Input<Float>()
                .withDefaultValue(0.0)
                .withLabel("Y")
                .asUserModifiable()
        )
        addInput(
            Input<Float>()
                .withDefaultValue(0.0)
                .withLabel("Z")
                .asUserModifiable()
        )

        addOutput(
            Output<Model>()
                .withLabel("Output Mesh")
        )
    }

    override func execute() throws {
        let primitiveType = inputs[0].currentValue as! PrimitiveType

        let primitive = Model(name: "Primitive Model", type: primitiveType)

        try outputs[0].setUntypedCurrentValue(to: primitive)
    }
}
