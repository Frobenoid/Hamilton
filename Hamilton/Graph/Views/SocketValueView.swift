//
//  SocketValueView.swift
//  Hamilton
//
//  Created by Milton Montiel on 09/12/25.
//

import MetalKit
import SwiftUI
import simd

protocol SocketValueView {
    associatedtype Value
    associatedtype Edit: View
    associatedtype Display: View

    @ViewBuilder func edit(_ value: Binding<Value>, label: String) -> Edit
    @ViewBuilder func display(_ value: Value, _ label: String) -> Display
}

extension SocketValueView {
    @ViewBuilder func show(_ value: Binding<Value>, when: Bool, label: String)
        -> some View
    {
        if when {
            edit(value, label: label)
        } else {
            display(value.wrappedValue, label)
        }
    }
}

extension Float: SocketValueView {
    func edit(_ value: Binding<Float>, label: String) -> some View {
        ScalarSlider<Float>(value: value, label: label)
    }

    func display(_ value: Float, _ label: String) -> some View {
        Text(
            "\((value).formatted(.number.precision(.fractionLength(3))))"
        )
    }
}

extension Int: SocketValueView {

    func edit(_ value: Binding<Int>, label: String) -> some View {
        ScalarSlider<Int>(value: value, label: label)
    }

    func display(_ value: Int, _ label: String) -> some View {
        Text(
            "\((value).formatted(.number.precision(.fractionLength(0))))"
        )
    }
}

extension SIMD3: SocketValueView {
    func edit(_ value: Binding<SIMD3>, label: String) -> some View {
        Vec3Field(value: value, label: label)

    }

    func display(_ value: SIMD3, _ label: String) -> some View {
        Text("Vec\(value.scalarCount)<\(type(of: value.x))>")
    }
}

extension MDLGeometryType: SocketValueView {
    func edit(_ value: Binding<MDLGeometryType>, label: String) -> some View {
        Picker(
            selection: value
        ) {
            Text("Lines").tag(MDLGeometryType.lines)
            Text("Quads").tag(MDLGeometryType.quads)
            Text("Tris").tag(MDLGeometryType.triangles)

        } label: {
            Text("Geometry Type").fontWeight(.bold)
        }
        .pickerStyle(.menu)
        .padding(.horizontal)
    }

    func display(_ value: MDLGeometryType, _ label: String) -> some View {
        Text("\(self)")
    }
}

extension PrimitiveType: SocketValueView {
    func edit(_ value: Binding<PrimitiveType>, label: String) -> some View {
        Picker(
            selection: value
        ) {
            ForEach(PrimitiveType.allCases) { type in
                Text(type.rawValue.capitalized)
                    .tag(type)
            }
        } label: {
            Text("Primtive").fontWeight(.bold)
        }
        .pickerStyle(.menu)
        .padding(.horizontal)
    }

    func display(_ value: PrimitiveType, _ label: String) -> some View {
        Text("Primitive: \(value.rawValue.capitalized)")
    }
}

extension Model: SocketValueView {
    func edit(_ value: Binding<Model>, label: String) -> some View {
        EmptyView()
    }

    func display(_ value: Model, _ label: String) -> some View {
        Text("\(value.name)")
    }

}
