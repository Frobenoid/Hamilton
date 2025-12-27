//
//  TimeNode.swift
//  Hamilton
//
//  Created by Milton Montiel on 08/12/25.
//

import Foundation

//class TimeNode: Node {
//
//    private var elapsedTime: Float = 0
//    private var lastSecond: Int = 0
//
//    override init() {
//        super.init()
//        label = "Time"
//
//        addOutput(
//            Output<Int>()
//                .withDefaultValue(0)
//                .withLabel("Seconds")
//        )
//
//        addOutput(
//            Output<Float>()
//                .withDefaultValue(0)
//                .withLabel("Elapsed")
//        )
//    }
//
//    /// This is updated from the scene update function.
//    func tick(deltaTime: Float) {
//        elapsedTime += deltaTime
//        let currentSecond = Int(elapsedTime)
//
//        if currentSecond != lastSecond {
//            lastSecond = currentSecond
//            try? outputs[0].setUntypedCurrentValue(to: currentSecond)
//        }
//        try? outputs[1].setUntypedCurrentValue(to: elapsedTime)
//    }
//
//}
