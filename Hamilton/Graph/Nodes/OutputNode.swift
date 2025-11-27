//
//  OutputNode.swift
//  Hamilton
//
//  Created by Milton Montiel on 25/11/25.
//

import Foundation

class OutputNode: Node {
    override init() {
        super.init()
        label = "Output Mesh"
        
        addInput(
            Input<Model>()
                .withLabel("Output Model")
                .withDefaultValue(.init(name: "Default Model", type: .box))
        )
    }
}
