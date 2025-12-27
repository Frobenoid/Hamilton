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

//class PrimitiveNode: Node {
//
//    var position: vector_float3 {
//        inputs[4].untypedCurrentValue() as! vector_float3
//    }
//
//    var rotation: vector_float3 {
//        inputs[5].untypedCurrentValue() as! vector_float3
//    }
//
//    var scale: Float {
//        inputs[6].untypedCurrentValue() as! Float
//    }
//
//    private enum Inputs: Int {
//        case PrimitiveType = 0
//        case Extent = 1
//        case GeometryType = 2
//        case Segments = 3
//    }
//
//    private enum Outputs: Int {
//        case OutputMesh = 0
//    }
//
//    override init() {
//        super.init()
//        label = "Primitive"
//
//        addInput(
//            Input<PrimitiveType>()
//                .withDefaultValue(.box)
//                .asUserModifiable()
//                .withLabel("Primitive Type")
//        )
//
//        addInput(
//            Input<vector_float3>()
//                .withDefaultValue([1.0, 1.0, 1.0])
//                .withLabel("Extent")
//                .asUserModifiable()
//        )
//
//        addInput(
//            Input<MDLGeometryType>()
//                .withDefaultValue(.triangles)
//                .withLabel("Geometry Type")
//                .asUserModifiable()
//        )
//
//        addInput(
//            Input<vector_uint3>()
//                .withDefaultValue(.one)
//                .withLabel("Segment")
//                .asUserModifiable()
//        )
//
//        // Transform
//        addInput(
//            Input<vector_float3>()
//                .withLabel("Position")
//                .withDefaultValue(.zero)
//                .asUserModifiable()
//        )
//
//        addInput(
//            Input<vector_float3>()
//                .withLabel("Rotation")
//                .withDefaultValue(.zero)
//                .asUserModifiable()
//        )
//
//        addInput(
//            Input<Float>()
//                .withLabel("Scale")
//                .withDefaultValue(1.0)
//                .asUserModifiable()
//        )
//
//        addOutput(
//            Output<Model>()
//                .withLabel("Output Mesh")
//        )
//    }
//
//    override func execute() throws {
//        let primitiveType =
//            inputs[Inputs.PrimitiveType.rawValue].currentValue as! PrimitiveType
//
//        let extent =
//            inputs[Inputs.Extent.rawValue].currentValue as! vector_float3
//
//        let geometryType =
//            inputs[Inputs.GeometryType.rawValue].currentValue
//            as! MDLGeometryType
//
//        let segments =
//            inputs[Inputs.Segments.rawValue].currentValue as! vector_uint3
//
//        var primitive = Model(
//            name: "Primitive Model",
//            type: primitiveType,
//            extent: extent,
//            segments: segments,
//            geometryType: geometryType
//        )
//
//        let transform = MDLTransform()
//        transform.translation = position
//        transform.rotation = rotation
//        transform.scale = vector_float3(x: scale, y: scale, z: scale)
//
//        primitive.transform = transform
//
//        try outputs[Outputs.OutputMesh.rawValue].setUntypedCurrentValue(
//            to: primitive
//        )
//    }
//}
