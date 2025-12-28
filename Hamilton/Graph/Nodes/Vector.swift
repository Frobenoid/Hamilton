//
//  Vector.swift
//  Hamilton
//
//  Created by Milton Montiel on 27/11/25.
//

import Foundation
import simd

struct VectorNode: NodeType {
    var label: String = "Vector"

    var description: String = "This is a 3-Vector"

    func exec(_ p: inout NodeParameters) throws {
        let x: Float = try p.getInput(at: 0)
        let y: Float = try p.getInput(at: 1)
        let z: Float = try p.getInput(at: 2)

        let output = vector_float3(x: x, y: y, z: z)

        try p.setOutput(at: 0, to: output)
    }

    func declare(_ b: inout ParameterBuilder) {
        b.addInput(
            Input<Float>()
                .withDefaultValue(1.0)
                .withLabel("X")
                .asUserModifiable()
        )

        b.addInput(
            Input<Float>()
                .withDefaultValue(1.0)
                .withLabel("Y")
                .asUserModifiable()
        )

        b.addInput(
            Input<Float>()
                .withDefaultValue(1.0)
                .withLabel("Z")
                .asUserModifiable()
        )

        b.addOutput(
            Output<vector_float3>()
                .withDefaultValue(.one)
                .withLabel("Vector")
        )
    }

}

//class UIntVectorNode: Node {
//    override init() {
//        super.init()
//        label = "UInt Vector"
//
//        addInput(
//            Input<Float>()
//                .withDefaultValue(1)
//                .withLabel("X")
//                .asUserModifiable()
//        )
//
//        addInput(
//            Input<Float>()
//                .withDefaultValue(1)
//                .withLabel("Y")
//                .asUserModifiable()
//        )
//
//        addInput(
//            Input<Float>()
//                .withDefaultValue(1)
//                .withLabel("Z")
//                .asUserModifiable()
//        )
//
//        addOutput(
//            Input<SIMD3<UInt32>>()
//                .withDefaultValue(.zero)
//                .withLabel("Vector")
//        )
//    }
//
//    override func execute() throws {
//        let x = inputs[0].untypedCurrentValue() as! Float
//        let y = inputs[1].untypedCurrentValue() as! Float
//        let z = inputs[2].untypedCurrentValue() as! Float
//
//        let output = vector_uint3(
//            x: UInt32(
//                x > 0 ? x : 0
//            ),
//            y: UInt32(
//                y > 0 ? y : 0
//            ),
//            z: UInt32(
//                z > 0 ? z : 0
//            )
//        )
//
//        try outputs[0].setUntypedCurrentValue(to: output)
//    }
//}
