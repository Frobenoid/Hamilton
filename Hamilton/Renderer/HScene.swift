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

    var models: [Model] = []
    var graph: Graph

    init(graph: Graph) {
        self.graph = graph
        self.models.append(
            graph.nodes[0].inputs[0].currentValue as! Model
        )

    }

    func update(size: CGSize) {
        //        camera.update(size: size)
        //        camera.currentViewSize = size
    }

    func update(deltaTime: Float) {
        //        camera.update(deltaTime: deltaTime)
    }
}
