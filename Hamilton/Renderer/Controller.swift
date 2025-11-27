//
//  Controller.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import Foundation
import MetalKit
import SwiftUI

class Controller: NSObject {
    var renderer: Renderer
    var scene: Binding<HScene>

    var lastTime: Double = CFAbsoluteTime()

    init(metalView: MTKView, scene: Binding<HScene>) {
        renderer = Renderer(metalView: metalView)
        self.scene = scene
        super.init()
        metalView.delegate = self
        mtkView(metalView, drawableSizeWillChange: metalView.drawableSize)
    }
}

extension Controller: MTKViewDelegate {
    /// Passes down view information to the scene and the renderer. This function is called
    /// on view change.
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        scene.wrappedValue.update(size: size)
        renderer.mtkView(view, drawableSizeWillChange: size)
    }

    /// Called each frame.
    func draw(in view: MTKView) {
        // MARK: - Time information
        let currentTime = CFAbsoluteTimeGetCurrent()
        let deltaTime = Float(currentTime - lastTime)
        lastTime = currentTime
        scene.wrappedValue.update(deltaTime: deltaTime)

        renderer.draw(scene: scene.wrappedValue, in: view)
    }

}
