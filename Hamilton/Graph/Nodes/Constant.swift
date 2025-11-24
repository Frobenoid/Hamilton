//
//  Constant.swift
//  Hamilton
//
//  Created by Milton Montiel on 15/11/25.
//

import Foundation

class ConstantNode: Node {
    override init() {
        super.init()
        label = "Constant"
        addOutput(
            Output<Float>()
                .withDefaultValue(1)
                .asUserModifiable()
        )
        
    }
}
