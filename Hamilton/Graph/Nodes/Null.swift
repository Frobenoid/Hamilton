//
//  NullType.swift
//  Hamilton
//
//  Created by Milton Montiel on 27/12/25.
//

import Foundation

struct NullNode: NodeType {
    var label: String = "Null"

    var description: String = "Testing node"

    func exec(_ p: NodeParameters) throws {
    }

    func declare(_ b: inout ParameterBuilder) {}
}
