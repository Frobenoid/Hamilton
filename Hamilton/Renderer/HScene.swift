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

    var camera: MDLCamera = {
        let camera = MDLCamera()
        camera.nearVisibilityDistance = 0.1
        camera.farVisibilityDistance = 100.0
        camera.fieldOfView = 45.0
        camera.look(at: [0,0,0], from: [0,0,5])
        return camera
    }()

    var graph: Graph

    init(graph: Graph) {
        self.graph = graph
    }

    func update(size: CGSize) {
        // Update aspect ratio when window resizes
        let aspect = Float(size.width / size.height)
        camera.sensorAspect = aspect
    }

    func update(deltaTime: Float) {
    }
}
