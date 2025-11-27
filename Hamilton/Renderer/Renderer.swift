//
//  Renderer.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import Foundation
import MetalKit

class Renderer: NSObject {
    static var device: MTLDevice! = {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Metal is not supported on this device.")
        }
        return device
    }()

    static var commandQueue: MTLCommandQueue! = {
        guard let commandQueue = device.makeCommandQueue() else {
            fatalError("Could not create command queue.")
        }
        return commandQueue
    }()

    static var library: MTLLibrary! = {
        return device.makeDefaultLibrary()
    }()

    var mesh: MTKMesh!
    var vertexBuffer: MTLBuffer!

    var pipelineState: MTLRenderPipelineState!
    // MARK: - Render passes
    var forwardPass: ForwardPass

    // Uniforms
    var uniforms = Uniforms()

    var lastTime: Double = CFAbsoluteTimeGetCurrent()

    init(metalView: MTKView) {
        metalView.device = Self.device

        // MARK: - Render pass initialization.
        forwardPass = ForwardPass(view: metalView)

        metalView.clearColor = MTLClearColor(
            red: 1.0,
            green: 1.0,
            blue: 1.0,
            alpha: 1.0
        )

        super.init()

        metalView.depthStencilPixelFormat = .depth32Float
        mtkView(metalView, drawableSizeWillChange: metalView.drawableSize)
    }

    static func buildDepthStencilState() -> MTLDepthStencilState? {
        let descriptor = MTLDepthStencilDescriptor()
        descriptor.depthCompareFunction = .less
        descriptor.isDepthWriteEnabled = true
        return Renderer.device.makeDepthStencilState(
            descriptor: descriptor
        )
    }
}

extension Renderer {
    /// Called on view change from ``ProtoScene``
    func mtkView(
        _ view: MTKView,
        drawableSizeWillChange size: CGSize
    ) {
        // MARK: - Render passes resizing
        forwardPass.resize(view: view, size: size)
    }

    func updateUniforms(scene: HScene) {
        uniforms.projectionMatrix = scene.camera.projectionMatrix
        uniforms.viewMatrix =
            scene.camera.transform?.matrix.inverse ?? matrix_identity_float4x4
    }

    /// Called each frame from the controller.
    func draw(scene: HScene, in view: MTKView) {
        guard
            let commandBuffer = Self.commandQueue.makeCommandBuffer(),
            let descriptor = view.currentRenderPassDescriptor
        else { return }

        updateUniforms(scene: scene)

        forwardPass.descriptor = descriptor
        forwardPass.draw(
            commandBuffer: commandBuffer,
            scene: scene,
            uniforms: uniforms
        )

        // MARK: - Presenting to a drawable
        guard let drawable = view.currentDrawable else {
            return
        }
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
