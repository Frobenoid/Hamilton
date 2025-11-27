//
//  SocketDeclarationView.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import MetalKit
import SwiftUI
import simd

struct SocketDeclarationView: View {

    var socket: any Socket
    @Environment(Graph.self) var graph
    var displayOnly: Bool = false

    func castedBinding<T>(_ type: T.Type = T.self) -> Binding<T> {
        return Binding(
            get: { socket.currentValue as! T },
            set: {
                newValue in
                try? socket.setUntypedCurrentValue(to: newValue)
                try? Evaluator(graph: graph).evaluate()
            }
        )
    }

    var body: some View {
        if socket.isUserModifiable && !displayOnly {
            switch socket.defaultValue {
            case is Float:
                // TODO: Custom slider here.
                CustomStepper(
                    value: castedBinding(Float.self),
                    label: socket.label
                )
            case is vector_float3:
                HStack {
                    Vec3Field(
                        value: castedBinding(vector_float3.self),
                        label: socket.label
                    )
                }
                .multilineTextAlignment(.center)

            case is MDLGeometryType:
                Picker(
                    selection: castedBinding(MDLGeometryType.self)
                ) {
                    Text("Lines").tag(MDLGeometryType.lines)
                    Text("Quads").tag(MDLGeometryType.quads)
                    Text("Tris").tag(MDLGeometryType.triangles)

                } label: {
                    Text("Geometry Type")
                }
                .pickerStyle(.menu)
                .padding(.horizontal)
            case is PrimitiveType:
                Picker(
                    selection: castedBinding(PrimitiveType.self)
                ) {
                    ForEach(PrimitiveType.allCases) { type in
                        Text(type.rawValue.capitalized)
                            .tag(type)
                    }
                } label: {
                    Text("Primtive")
                }
                .pickerStyle(.menu)
                .padding(.horizontal)
            default:
                Text("Any")
            }
        } else {
            // Display info only.
            switch socket.defaultValue {
            case is Float:
                Text(
                    "\((socket.currentValue as! Float).formatted(.number.precision(.fractionLength(3))))"
                )
            case is PrimitiveType:
                Text("\(socket.currentValue as! PrimitiveType)")
            default:
                Text("Any")
            }
        }
    }
}
