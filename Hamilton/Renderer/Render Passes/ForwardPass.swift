//
//  ForwardPass.swift
//  Hamilton
//
//  Created by Milton Montiel on 27/11/25.
//

import Foundation
import MetalKit

struct ForwardPass: RenderPass {
    var label: String = "Forward Pass"

    var descriptor: MTLRenderPassDescriptor?
    var depthStencilState: MTLDepthStencilState?
    var pipelineState: MTLRenderPipelineState

    init(view: MTKView) {
        pipelineState = PipelinesStates.createForwardPSO(
            colorPixelFormat: view.colorPixelFormat
        )
        depthStencilState = Renderer.buildDepthStencilState()
    }

    mutating func resize(view: MTKView, size: CGSize) {
    }

    func draw(
        commandBuffer: any MTLCommandBuffer,
        scene: HScene,
        uniforms: Uniforms
    ) {
        guard
            let descriptor = descriptor,
            let renderEncoder = commandBuffer.makeRenderCommandEncoder(
                descriptor: descriptor
            )
        else {
            return
        }

        // MARK: Encoder setup.
        renderEncoder.label = label
        renderEncoder.setDepthStencilState(depthStencilState)
        renderEncoder.setRenderPipelineState(pipelineState)

        // MARK: Model rendering.
        scene.models.forEach { model in
            model.render(
                encoder: renderEncoder,
                uniforms: uniforms
            )
        }
        
        renderEncoder.endEncoding()
    }

}
