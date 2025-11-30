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

    var camera = FirstPerson()

    var graph: Graph

    init(graph: Graph) {
        self.graph = graph
    }

    /// Update aspect ratio when window resizes
    func update(size: CGSize) {
        camera.updateAspect(size: size)
    }

    /// Update the camera based on the delta time.
    func update(deltaTime: Float) {

        let input = InputController.sharedController

        var transform = Transform()

        if input.pressedKeys.contains(.keyW) {
            transform.positon.z -= 1
        }

        if input.pressedKeys.contains(.keyS) {
            transform.positon.z += 1
        }

        if input.pressedKeys.contains(.keyA) {
            transform.positon.x -= 1
        }

        if input.pressedKeys.contains(.keyD) {
            transform.positon.x += 1
        }

        if transform.positon != .zero {
            camera.position += transform.positon
        }
    }
}
