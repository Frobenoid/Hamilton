//
//  HScene.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import Foundation
import ModelIO
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

    var camera: any Camera = FirstPerson()

    var graph: Graph

    init(graph: Graph) {
        self.graph = graph
    }

    /// Update aspect ratio when window resizes
    func update(size: CGSize) {
        camera.updateAspect(size: size)
    }

    /// Handle input keys using the delta time.
    func update(deltaTime: Float) {
        for command in InputController.sharedController.commands() {
            command.execute(scene: self, deltaTime: deltaTime)
        }
    }
}
