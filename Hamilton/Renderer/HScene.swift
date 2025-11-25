//
//  HScene.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import Foundation

@Observable
class HScene {

    var models: [Model] = []

    init() {
        self.models.append(Model(name: "sphere", type: .box))
    }

    func update(size: CGSize) {
        //        camera.update(size: size)
        //        camera.currentViewSize = size
    }

    func update(deltaTime: Float) {
        //        camera.update(deltaTime: deltaTime)
    }
}
