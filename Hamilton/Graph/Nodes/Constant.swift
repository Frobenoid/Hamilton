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
        addOutput(Output<Int>().withDefaultValue(0))
    }
}
