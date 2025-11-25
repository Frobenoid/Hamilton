//
//  CustomStepper.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import SwiftUI

struct CustomStepper: View {
    @Binding var value: Float

    var label: String

    private static var formatter: NumberFormatter {
        var formatter = NumberFormatter()
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
            Text(
                "\(label)"
            )
            Spacer()
            HStack {
                Button(action: { decrementStep() }) {
                    Image(systemName: "minus")
                }
                .buttonRepeatBehavior(.enabled)
                TextField(
                    "",
                    value: $value,
                    formatter: Self.formatter
                )
                .textFieldStyle(.plain)
                .font(.callout)
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
    CustomStepper(value: $value, label: "Test")
}
