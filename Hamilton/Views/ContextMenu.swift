//
//  ContextMenu.swift
//  Hamilton
//
//  Created by Milton Montiel on 30/11/25.
//

import SwiftUI

struct ContextMenu: View {
    @Environment(Graph.self) var graph
    var initialPosition: CGPoint = .zero

    var editorMode: EditorMode
    var body: some View {
        if editorMode == .Edit {
            Text("Add")
                .font(.headline)
                .bold()
            // TODO: Instead of calling methods directly into
            // TODO: the graph this should add them into a dispatch queue.
            Menu {
                Button {
                    graph.addNode(ConstantNode())
                } label: {
                    Image(systemName: "number")
                    Text("Constant")
                }

                Button {
                    graph.addNode(BinOpNode())
                } label: {
                    Image(systemName: "sum")
                    Text("Binary Operation")
                }

                Button {
                    graph.addNode(VectorNode())
                } label: {
                    Image(systemName: "curlybraces")
                    Text("Vector")
                }

                Button {
                    let node = UIntVectorNode()
                    node.initialPosition = initialPosition
                    graph.addNode(node)
                } label: {
                    Image(systemName: "curlybraces")
                    Text("UInt Vector")
                }

            } label: {
                Image(systemName: "sum")
                Text("Math")
            }

            Button {
                graph.addNode(PrimitiveNode())
            } label: {
                Image(systemName: "rotate.3d")
                Text("Primitive")
            }

            Button {
                graph.addNode(SubdivisionNode())
            } label: {
                Image(systemName: "rotate.3d")
                Text("Subdivision")
            }

            Button {
                graph.addNode(TimeNode())
            } label: {
                Image(systemName: "timer")
                Text("Time")
            }

            Button {
                graph.addNode(WaveNode())
            } label: {
                Image(systemName: "waveform.path")
                Text("Wave")
            }

            Button {
                graph.addNode(TransformNode())
            } label: {
                Image(systemName: "move.3d")
                Text("Transform")
            }
        }
    }
}

#Preview {
    @Previewable @State var graph = Graph()
    ContextMenu(editorMode: .Edit).environment(graph)
    ContextMenu(editorMode: .Normal).environment(graph)
}
