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

class PrimitiveNode: Node {

    private enum Inputs: Int {
        case PrimitiveType = 0
        case Extent = 1
        case GeometryType = 2
    }

    private enum Outputs: Int {
        case OutputMesh = 0
    }

    override init() {
        super.init()
        label = "Primitive"

        // Type of the primitive.
        addInput(
            Input<PrimitiveType>()
                .withDefaultValue(.box)
                .asUserModifiable()
                .withLabel("Primitive Type")
        )

        addInput(
            Input<vector_float3>()
                .withDefaultValue([1.0, 1.0, 1.0])
                .withLabel("Extent")
                .asUserModifiable()
        )

        addInput(
            Input<MDLGeometryType>()
                .withDefaultValue(.triangles)
                .withLabel("Geometry Type")
                .asUserModifiable()
        )

        addOutput(
            Output<Model>()
                .withLabel("Output Mesh")
        )
    }

    override func execute() throws {
        let primitiveType =
            inputs[Inputs.PrimitiveType.rawValue].currentValue as! PrimitiveType

        let extent =
            inputs[Inputs.Extent.rawValue].currentValue as! vector_float3

        let geometryType =
            inputs[Inputs.GeometryType.rawValue].currentValue
            as! MDLGeometryType

        let primitive = Model(
            name: "Primitive Model",
            type: primitiveType,
            extent: extent,
            geometryType: geometryType
        )

        try outputs[Outputs.OutputMesh.rawValue].setUntypedCurrentValue(
            to: primitive
        )
    }
}
