//
//  ContextMenu.swift
//  Hamilton
//
//  Created by Milton Montiel on 30/11/25.
//

import SwiftUI

struct ContextMenu: View {
    @Environment(Graph.self) var graph

    var editorMode: EditorMode
    var body: some View {
        if editorMode == .Edit {
            Text("Add")
                .font(.headline)
                .bold()
            Menu {
                Button {
                    graph.addNode(ConstantNode())

                    //  AddNodeCommand(node: ConstantNode())
                } label: {
                    Image(systemName: "number")
                    Text("Constant")
                }

                Button {
                    graph.addNode(BinOpNode())
                    //                        AddNodeCommand(node: BinOpNode())
                } label: {
                    Image(systemName: "sum")
                    Text("Binary Operation")
                }

                Button {
                    graph.addNode(VectorNode())
                    //                        AddNodeCommand(node: VectorNode())
                } label: {
                    Image(systemName: "curlybraces")
                    Text("Vector")
                }
            } label: {
                Image(systemName: "sum")
                Text("Math")
            }

            Button {
                graph.addNode(PrimitiveNode())
                //                    AddNodeCommand(node: PrimitiveNode())
            } label: {
                Image(systemName: "rotate.3d")
                Text("Primitive")
            }

            Button {
                graph.addNode(SubdivisionNode())
                //                    AddNodeCommand(node: PrimitiveNode())
            } label: {
                Image(systemName: "rotate.3d")
                Text("Subdivision")
            }

        }
    }
}

#Preview {
    @Previewable @State var graph = Graph()
    ContextMenu(editorMode: .Edit).environment(graph)
    ContextMenu(editorMode: .Normal).environment(graph)
}
