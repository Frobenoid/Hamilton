//
//  SocketView.swift
//  Hamilton
//
//  Created by Milton Montiel on 23/11/25.
//

import SwiftUI

struct InputView: View {
    var input: any Socket
    @Environment(Graph.self) var graph

    var body: some View {
        HStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 20)
                .dropDestination(for: DraggableData.self) {
                    draggableData,
                    destination in

                    if input.isConnected {
                        print("Connection rejected, already connected")
                        return false
                    }

                    if let first = draggableData.first {

                        graph.connect(
                            sourceNode: first.sourceNode,
                            sourceSocket: first.sourceSocket,
                            destinationNode: input.parentID,
                            destinationSocket: input.id
                        )
                        // Evaluation...
                        try! Evaluator(graph: graph).evaluate()
                    }

                    return true
                }
                .anchorPreference(
                    key: SocketAnchorKey.self,
                    value: .center,
                    transform: {
                        anchor in
                        [
                            SocketAnchor(
                                nodeID: input.parentID,
                                socketID: input.id,
                            ): anchor
                        ]
                    }
                )

            // Bidirectional / Reactive Value Display
            if input.isConnected {
                // Read-only when connected (value comes from source)
                Text("\(input.currentValue)")
                    .foregroundStyle(.secondary)
            } else {
                if let inp = input as? Input<Float> {
                    Slider(
                        value: Binding(
                            get: { inp.currentValue ?? 0.0 },
                            set: { newValue in
                                try? inp.setUntypedCurrentValue(
                                    to: newValue
                                )
                                // 2. Trigger Reactivity (Propagate)
                                try? Evaluator(graph: graph).evaluate()
                            }
                        ),
                        in: 0...1
                    )
                }
                // Editable when disconnected
            }
        }
    }
}

struct OutputView: View {
    var output: any Socket
    @Environment(Graph.self) var graph

    var body: some View {
        HStack {
            Text("\(output.currentValue)")
            if let out = output as? Output<Float> {

                Slider(
                    value: Binding(
                        get: { out.currentValue ?? 0.0 },
                        set: { newValue in
                            try? out.setUntypedCurrentValue(
                                to: newValue
                            )
                            // 2. Trigger Reactivity (Propagate)
                            try? Evaluator(graph: graph).evaluate()
                        }
                    ),
                    in: -1...1
                )
            }
            Circle()
                .fill(Color.red)
                .frame(width: 20)
                .anchorPreference(
                    key: SocketAnchorKey.self,
                    value: .center,
                    transform: {
                        anchor in
                        [
                            SocketAnchor(
                                nodeID: output.parentID,
                                socketID: output.id,
                                isOutput: true
                            ): anchor
                        ]
                    }
                )
                .draggable(
                    DraggableData(
                        sourceSocket: output.id,
                        sourceNode: output.parentID,
                    )
                )
        }
    }
}

#Preview {
    @Previewable @State var graph = Graph()
    @Previewable @State var input: any Socket = Input<Float>().withDefaultValue(
        0
    )

    InputView(input: input).environment(graph)
}
