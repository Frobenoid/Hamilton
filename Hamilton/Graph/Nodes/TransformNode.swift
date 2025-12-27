//
//  TransformNode.swift
//  Hamilton
//
//  Created by Milton Montiel on 08/12/25.
//

import Foundation
import MetalKit
import simd

//class TransformNode: Node {
//
//    var position: vector_float3 {
//        inputs[1].currentValue as! vector_float3
//    }
//
//    var rotation: vector_float3 {
//        inputs[2].currentValue as! vector_float3
//    }
//
//    var scale: Float {
//        inputs[3].currentValue as! Float
//    }
//
//    override init() {
//        super.init()
//        label = "Transform"
//
//        addInput(
//            Input<Model>()
//                .withLabel("Model")
//        )
//
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
//                .withLabel("Model")
//        )
//    }
//
//    override func execute() throws {
//        let transform = MDLTransform()
//        transform.translation = position
//        transform.rotation = rotation
//        transform.scale = [scale, scale, scale]
//
//        if var model = inputs[0].currentValue as? Model {
//            model.transform = transform
//
//            try outputs[0].setUntypedCurrentValue(to: model)
//        }
//    }
//}
