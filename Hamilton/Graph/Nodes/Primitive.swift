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
        // Type of the primitive.
        addOutput(
            Output<PrimitiveType>()
                .withDefaultValue(.box)
                .asUserModifiable()
                .withLabel("Primitive Type")
        )

        // Scale
        addInput(
            Input<Float>()
                .withDefaultValue(1.0)
                .asUserModifiable()
                .withLabel("Scale")
        )
    }
}
