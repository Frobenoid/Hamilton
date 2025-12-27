//
//  Constant.swift
//  Hamilton
//
//  Created by Milton Montiel on 15/11/25.
//

import Foundation

struct ConstantNode: NodeType {
    var label: String = "Consant"

    var description: String = "A constant floating point value"

    func exec(_ p: NodeParameters) throws {
    }

    func declare(_ b: inout ParameterBuilder) {
        b.addOutput(
            Output<Float>()
                .withDefaultValue(1)
                .withLabel("Value")
                .asUserModifiable()
        )
    }
}
