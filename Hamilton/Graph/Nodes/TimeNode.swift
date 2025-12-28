//
//  TimeNode.swift
//  Hamilton
//
//  Created by Milton Montiel on 08/12/25.
//

import Foundation

struct TimeNode: NodeType {
    var label: String = "Time"
    var description: String = "A scene time node"
    private var elapsedTime: Float = 0
    private var lastSecond: Int = 0
    private var p: NodeParameters

    func exec(_ p: inout NodeParameters) throws {
        // TODO: !
    }

    func declare(_ b: inout ParameterBuilder) {
        b.addOutput(
            Output<Int>()
                .withDefaultValue(0)
                .withLabel("Seconds")
        )

        b.addOutput(
            Output<Float>()
                .withDefaultValue(0)
                .withLabel("Elapsed")
        )
    }
}
