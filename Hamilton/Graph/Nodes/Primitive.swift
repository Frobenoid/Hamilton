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
        addOutput(
            Output<PrimitiveType>()
                .withDefaultValue(.box)
                .asUserModifiable()
        )
    }
}
