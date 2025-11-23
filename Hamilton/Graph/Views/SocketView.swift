//
//  SocketView.swift
//  Hamilton
//
//  Created by Milton Montiel on 23/11/25.
//

import SwiftUI

struct InputView: View {
    var input: any Socket

    var body: some View {
        HStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 20)
            Text("\(input.currentValue)")
        }
    }
}

struct OutputView: View {
    var output: any Socket
    var body: some View {
        HStack {
            Text("\(output.currentValue)")
            Circle()
                .fill(Color.red)
                .frame(width: 20)
        }
    }
}

#Preview {
    @Previewable @State var input: any Socket = Input<Int>().withDefaultValue(0)

    InputView(input: input)
}
