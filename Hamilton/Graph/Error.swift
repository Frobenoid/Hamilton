//
//  Error.swift
//  Hamilton
//
//  Created by Milton Montiel on 15/11/25.
//

import Foundation

enum GraphError: Error {
    case imposibleCasting(from: Any, to: Any)
    /// Out of range access.
    case outOfRangeNode(node: NodeID)
    case outOfRangeInput(input: SocketID)
    case outOfRangeOutput(output: SocketID)

    /// Evaluator related errors.
    case containsDirectedCycle(graph: Graph, node: NodeID)
}
