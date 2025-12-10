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
        let this = socket.isUserModifiable && !displayOnly
        if socket.currentValue is any SocketValueView {
            switch socket.currentValue {
            case let s as Float:
                s.show(
                    castedBinding(),
                    when: this,
                    label: socket.label
                )
            case let s as Int:
                s.show(
                    castedBinding(),
                    when: this,
                    label: socket.label
                )
            case let s as vector_float3:
                s.show(
                    castedBinding(),
                    when: this,
                    label: socket.label
                )
            case let s as vector_uint3:
                s.show(
                    castedBinding(),
                    when: this,
                    label: socket.label
                )
            case let s as MDLGeometryType:
                s.show(
                    castedBinding(),
                    when: this,
                    label: socket.label
                )
            case let s as PrimitiveType:
                s.show(
                    castedBinding(),
                    when: this,
                    label: socket.label
                )
            case let s as Model:
                s.show(
                    castedBinding(),
                    when: this,
                    label: socket.label
                )
            default:
                EmptyView()
            }
        } else {
            Text("Unimplemented")
        }
    }
}
