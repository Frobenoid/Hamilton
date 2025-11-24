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
    func incrementStep() {
        value += 0.5
    }

    func decrementStep() {
        value -= 0.5
    }

    var body: some View {
        Stepper {
            Text(
                "\(label) : \(value.formatted(.number.precision(.fractionLength(3))))"
            )
        } onIncrement: {
            incrementStep()
        } onDecrement: {
            decrementStep()
        }
        .padding(.horizontal)
    }
}

#Preview {
    @Previewable @State var value: Float = 0
    CustomStepper(value: $value, label: "Test")
}
