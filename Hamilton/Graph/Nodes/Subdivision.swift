//
//  Subdivision.swift
//  Hamilton
//
//  Created by Milton Montiel on 30/11/25.
//
import ModelIO

class Subdivision: Node {

    override init() {
        super.init()

        addInput(
            Input<Model>()
                .withLabel("Model")
        )

        addInput(
            Input<Int>()
                .withDefaultValue(1)
                .withLabel("Subdivision Level")
                .asUserModifiable()
        )

        addOutput(
            Output<Model>()
                .withLabel("Subdivided")
                .withDefaultValue(
                    Model(name: "Remove this", type: .cone)
                )
        )
    }

    override func execute() throws {

        if let model = inputs[0].untypedCurrentValue() as? Model {
            let subdivisionLevels = inputs[1].untypedCurrentValue() as! Int

            model.subdivide(subdivisionLevels: subdivisionLevels)

            try outputs[0].setUntypedCurrentValue(to: model)
        } else {
            return
        }

    }
}
