//
//  HScene.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import Foundation
import SwiftUI

@Observable
class HScene {

    var models: [Model] {
        guard
            let model = graph.nodes[0].inputs[0].currentValue as? Model
        else {
            return []
        }
        return [model]
    }

    var graph: Graph

    init(graph: Graph) {
        self.graph = graph
    }

    func update(size: CGSize) {
    }

    func update(deltaTime: Float) {
    }
}
