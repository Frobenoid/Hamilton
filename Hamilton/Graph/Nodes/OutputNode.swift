//
//  OutputNode.swift
//  Hamilton
//
//  Created by Milton Montiel on 25/11/25.
//

import Foundation

struct OutputNode: NodeType {
    var label: String = "Output Mesh"

    var description: String = "This node outputs a mesh"

    func exec(_ p: inout NodeParameters) throws {}

    func declare(_ b: inout ParameterBuilder) {
        b.addInput(
            Input<Model>()
                .withLabel("Output Model")
                .withDefaultValue(.init(name: "Default Model", type: .box))
        )
    }
}
