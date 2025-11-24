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
    @Previewable @State var input: any Socket = Input<Int>().withDefaultValue(0)

    InputView(input: input)
}
