//
//  Render Pass.swift
//  Hamilton
//
//  Created by Milton Montiel on 27/11/25.
//

import Foundation
import MetalKit

protocol RenderPass {
    var label: String { get }
    var descriptor: MTLRenderPassDescriptor? { get set }

    mutating func resize(view: MTKView, size: CGSize)
    func draw(
        commandBuffer: MTLCommandBuffer,
        scene: HScene,
        uniforms: Uniforms
    )
}
