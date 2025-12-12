//
//  Subdivision.swift
//  Hamilton
//
//  Created by Milton Montiel on 30/11/25.
//
import ModelIO

class SubdivisionNode: Node {

    var inputModel: Model? {
        inputs[0].currentValue as? Model
    }

    var subdivisionLevel: Int {
        inputs[1].currentValue as! Int
    }

    var outputSubdividedModel: Model {
        get {
            outputs[0].currentValue as! Model
        }
        set {
            try? outputs[0].setUntypedCurrentValue(to: newValue)
        }
    }

    override init() {
        super.init()

        label = "Subdivision"

        addInput(
            Input<Model>()
                .withLabel("Model")
        )

        addInput(
            Input<Int>()
                .withDefaultValue(1)
                .withLabel("Level")
                .asUserModifiable()
        )

        addOutput(
            Output<Model>()
                .withLabel("Subdivided")
        )
    }

    override func execute() throws {
        if let model = inputModel {

            outputSubdividedModel = Model.subdivide(
                model,
                level: subdivisionLevel
            )

        } else {
            return
        }
    }
}
