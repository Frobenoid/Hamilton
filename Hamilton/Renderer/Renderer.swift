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
    //    var forwardPass: ForwardPass
    //    var wireframePass: WireframePass

    // Uniforms
    //    var uniforms = Uniforms()
    //    var params = Params()

    var lastTime: Double = CFAbsoluteTimeGetCurrent()

    init(metalView: MTKView) {
        guard
            let device = MTLCreateSystemDefaultDevice(),
            let commandQueue = device.makeCommandQueue()
        else {
            fatalError("Metal is not supported on this device.")
        }
        Self.device = device
        Self.commandQueue = commandQueue
        metalView.device = Self.device

        // Mesh creation
        let allocator = MTKMeshBufferAllocator(device: Renderer.device)
        let mdlMesh = MDLMesh(
            boxWithExtent: [1, 1, 0.5],
            segments: [1, 1, 1],
            inwardNormals: false,
            geometryType: .triangles,
            allocator: allocator
        )

        do {
            mesh = try MTKMesh(mesh: mdlMesh, device: Renderer.device)
        } catch {
            print(error.localizedDescription)
        }

        vertexBuffer = mesh.vertexBuffers[0].buffer

        //        metalView.depthStencilPixelFormat = .depth32Float
        // Metal library setup
        let library = Renderer.device.makeDefaultLibrary()
        Self.library = library
        let vertexFunction = library?.makeFunction(name: "vertex_main")
        let fragmentFunction = library?.makeFunction(name: "fragment_main")

        // PSO creation
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat =
            metalView.colorPixelFormat
        pipelineDescriptor.vertexDescriptor =
            .defaultLayout

        do {
            pipelineState = try Renderer.device.makeRenderPipelineState(
                descriptor: pipelineDescriptor
            )
        } catch {
            fatalError(error.localizedDescription)
        }

        super.init()

        metalView.clearColor = MTLClearColor(
            red: 1.0,
            green: 1.0,
            blue: 0.8,
            alpha: 1.0
        )

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
        //        forwardPass.resize(view: view, size: size)
    }

    func updateUniforms(scene: HScene) {
        //        uniforms.viewMatrix = scene.camera.viewMatrix
        //        uniforms.projectionMatrix = scene.camera.projectionMatrix
        //        params.cameraPosition = scene.camera.position
        //        params.lightCount = UInt32(scene.lighting.lights.count)
    }

    /// Called each frame from ``Scene``.
    func draw(scene: HScene, in view: MTKView) {
        guard
            let commandBuffer = Self.commandQueue.makeCommandBuffer(),
            let descriptor = view.currentRenderPassDescriptor,
            let renderEncoder = commandBuffer.makeRenderCommandEncoder(
                descriptor: descriptor
            )
        else { return }

        updateUniforms(scene: scene)

        //        renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
        //        renderEncoder.drawIndexedPrimitives(
        //            type: .triangle,
        //            indexCount: 3,
        //            indexType: .uint32,
        //            indexBuffer: ,
        //            indexBufferOffset: 0
        //        )

        // MARK: - Render passes
        //        wireframePass.descriptor = descriptor
        //        wireframePass.draw(
        //            commandBuffer: commandBuffer,
        //            scene: scene,
        //            uniforms: uniforms,
        //            params: params
        //        )
        //
        //        forwardPass.descriptor = descriptor
        //        forwardPass.draw(
        //            commandBuffer: commandBuffer,
        //            scene: scene,
        //            uniforms: uniforms,
        //            params: params
        //        )

        var uniforms = Uniforms(
            projectionMatrix: scene.camera.projectionMatrix,
            worldViewMatrix: scene.camera.transform?.matrix.inverse ?? matrix_identity_float4x4
            
        )

        renderEncoder.setVertexBytes(
            &uniforms,
            length: MemoryLayout<Uniforms>.stride,
            index: 1
        )

        renderEncoder.setRenderPipelineState(pipelineState)
        //        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        //        for submesh in mesh.submeshes {
        //            renderEncoder.drawIndexedPrimitives(
        //                type: .lineStrip,
        //                indexCount: submesh.indexCount,
        //                indexType: submesh.indexType,
        //                indexBuffer: submesh.indexBuffer.buffer,
        //                indexBufferOffset: submesh.indexBuffer.offset
        //            )
        //        }

        for model in scene.models {
            model.render(encoder: renderEncoder)
        }

        renderEncoder.endEncoding()

        // MARK: - Presenting to a drawable
        guard let drawable = view.currentDrawable else {
            return
        }
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
