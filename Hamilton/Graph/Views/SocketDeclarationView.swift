//
//  SocketDeclarationView.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import SwiftUI

struct SocketDeclarationView: View {
    var socket: any Socket
    @Environment(Graph.self) var graph

    var body: some View {
        switch socket.defaultValue {
        case is Float:
            // TODO: Custom slider here.
            Slider(
                value: Binding(
                    get: { socket.currentValue as! Float },
                    set: { newValue in
                        try? socket.setUntypedCurrentValue(
                            to: newValue
                        )
                        try? Evaluator(graph: graph).evaluate()
                    }
                ),
                in: 0...1
            )
        case is PrimitiveType:
            Picker(
                "Primitive",
                selection: Binding(
                    get: { socket.currentValue as! PrimitiveType },
                    set: {
                        newValue in
                        try? socket.setUntypedCurrentValue(to: newValue)
                        try? Evaluator(graph: graph).evaluate()
                    }
                )
            ) {
                ForEach(PrimitiveType.allCases) { type in
                    Text(type.rawValue.capitalized)
                        .tag(type)
                }

            }
        default:
            Text("Any")
        }
    }
}
