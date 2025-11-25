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
    @Environment(NodeUISettings.self) var uiSettings

    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                HStack {
                    SocketPin()
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
                }
                .frame(width: geo.size.width / uiSettings.widthFraction)
                Divider()
                SocketDeclarationView(
                    socket: input,
                    displayOnly: input.isConnected
                )
                .frame(width: geo.size.width * 9 / uiSettings.widthFraction)
                Divider()
                HStack {
                }.frame(width: geo.size.width / uiSettings.widthFraction)
            }
        }.frame(height: NodeUISettings().socketSectionSize)
    }
}

struct OutputView: View {
    var output: any Socket
    @Environment(Graph.self) var graph
    @Environment(NodeUISettings.self) var uiSettings

    var body: some View {

        GeometryReader { geo in
            HStack(spacing: 0) {
                HStack {
                }.frame(width: geo.size.width / uiSettings.widthFraction)
                Divider()
                SocketDeclarationView(socket: output)
                    .frame(width: geo.size.width * 9 / uiSettings.widthFraction)
                Divider()
                HStack {
                    SocketPin()
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
                .frame(
                    width: geo.size.width / uiSettings.widthFraction,
                    alignment: .center
                )
            }
        }.frame(height: uiSettings.socketSectionSize)
    }
}

#Preview {
    @Previewable @State var settings = NodeUISettings()
    @Previewable @State var graph = Graph()
    @Previewable @State var input: any Socket = Input<Float>().withDefaultValue(
        0
    )
    .withLabel("Value")
    .asUserModifiable()

    @Previewable @State var output: any Socket = Output<PrimitiveType>()
        .withDefaultValue(
            .sphere
        )
        .withLabel("Primitive")
        .asUserModifiable()

    InputView(input: input).environment(graph)
        .environment(settings)
        .border(Color.gray.opacity(0.3))
        .frame(width: 350)
        .padding(20)

    OutputView(output: output).environment(graph)
        .environment(settings)
        .border(Color.gray.opacity(0.3))
        .frame(width: 350)
        .padding(20)
}
