//
//  CustomStepper.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import SwiftUI
import simd

struct Vec3Field<Number: SIMDScalar>: View {
    
    enum Format {
        case decimal, integer
    }
    
    @Binding var value: SIMD3<Number>

    var label: String
    var format: Format = .decimal

    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        if self.format == .integer {
            formatter.minimumFractionDigits = 0
            formatter.allowsFloats = false
        } else {
            formatter.minimumFractionDigits = 3
            formatter.allowsFloats = true
        }
        return formatter
    }

    var body: some View {
        HStack {
            Text(
                "\(label)"
            )
            TextField(
                "",
                value: $value.x,
                formatter: self.formatter
            )
            .textFieldStyle(.plain)
            .font(.callout)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(5)

            TextField(
                "",
                value: $value.y,
                formatter: self.formatter
            )
            .textFieldStyle(.plain)
            .font(.callout)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(5)
            TextField(
                "",
                value: $value.z,
                formatter: self.formatter
            )
            .textFieldStyle(.plain)
            .font(.callout)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(5)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal)
    }
}

struct CustomStepper: View {
    @Binding var value: Float

    var label: String

    private static var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 3
        return formatter
    }

    func incrementStep() {
        value += 0.5
    }

    func decrementStep() {
        value -= 0.5
    }

    var body: some View {
        HStack {
            HStack {
                Button(action: { decrementStep() }) {
                    Image(systemName: "minus")
                }
                .buttonRepeatBehavior(.enabled)
                HStack {
                    Text(
                        "\(label)"
                    ).fontWeight(.bold)
                    TextField(
                        "",
                        value: $value,
                        formatter: Self.formatter
                    )
                    .textFieldStyle(.plain)
                    .font(.callout)
                }
                .multilineTextAlignment(.center)

                Button(action: { incrementStep() }) {
                    Image(systemName: "plus")
                }
                .buttonRepeatBehavior(.enabled)
            }
            .background(Color.gray.opacity(0.3))
            .cornerRadius(5)
        }
        .padding(.horizontal)
    }
}

#Preview {
    @Previewable @State var value: Float = 0
    @Previewable @State var vec: vector_float3 = .one
    CustomStepper(value: $value, label: "Test")

    Vec3Field(value: $vec, label: "Vec")
}
