//
//  Primitive.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import Foundation
import MetalKit
import simd

enum PrimitiveType: String, CaseIterable, Identifiable {
    var id: Self { self }
    case sphere
    case box
    case cylinder
    case cone
    case capsule
}

struct PrimitiveNode: NodeType {
    var label: String = "Primitive"

    var description: String = "A primitive mesh"

    private enum Inputs: Int {
        case PrimitiveType = 0
        case Extent = 1
        case GeometryType = 2
        case Segments = 3
    }

    private enum Outputs: Int {
        case OutputMesh = 0
    }

    func exec(_ p: inout NodeParameters) throws {
        let primitiveType: PrimitiveType = try p.getInput(
            at: Inputs.PrimitiveType.rawValue
        )

        let extent: vector_float3 = try p.getInput(at: Inputs.Extent.rawValue)

        let geometryType: MDLGeometryType = try p.getInput(
            at: Inputs.GeometryType.rawValue
        )

        let segments: vector_uint3 = try p.getInput(
            at: Inputs.Segments.rawValue
        )

        var primitive = Model(
            name: "Primitive Model",
            type: primitiveType,
            extent: extent,
            segments: segments,
            geometryType: geometryType
        )

        let position: vector_float3 = try p.getInput(at: 4)
        let rotation: vector_float3 = try p.getInput(at: 5)
        let scale: Float = try p.getInput(at: 6)

        let transform = MDLTransform()
        transform.translation = position
        transform.rotation = rotation
        transform.scale = vector_float3(x: scale, y: scale, z: scale)

        primitive.transform = transform

        try p.setOutput(at: Outputs.OutputMesh.rawValue, to: primitive)
    }

    func declare(_ b: inout ParameterBuilder) {
        b.addInput(
            Input<PrimitiveType>()
                .withDefaultValue(.box)
                .asUserModifiable()
                .withLabel("Primitive Type")
        )

        b.addInput(
            Input<vector_float3>()
                .withDefaultValue([1.0, 1.0, 1.0])
                .withLabel("Extent")
                .asUserModifiable()
        )

        b.addInput(
            Input<MDLGeometryType>()
                .withDefaultValue(.triangles)
                .withLabel("Geometry Type")
                .asUserModifiable()
        )

        b.addInput(
            Input<vector_uint3>()
                .withDefaultValue(.one)
                .withLabel("Segment")
                .asUserModifiable()
        )

        b.addInput(
            Input<vector_float3>()
                .withLabel("Position")
                .withDefaultValue(.zero)
                .asUserModifiable()
        )

        b.addInput(
            Input<vector_float3>()
                .withLabel("Rotation")
                .withDefaultValue(.zero)
                .asUserModifiable()
        )

        b.addInput(
            Input<Float>()
                .withLabel("Scale")
                .withDefaultValue(1.0)
                .asUserModifiable()
        )

        b.addOutput(
            Output<Model>()
                .withLabel("Output Mesh")
        )
    }

}
