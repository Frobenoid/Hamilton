//
//  GraphCanvas.swift
//  Hamilton
//
//  Created by Milton Montiel on 23/11/25.
//

import SwiftUI

struct GraphCanvasView: View {
    @Environment(Graph.self) var graph: Graph
    @State var contextMenuPosition: CGPoint = .zero
    var body: some View {
        GeometryReader { geo in
            CanvasView(
                content: {
                    ForEach(graph.nodes, id: \.id) { node in
                        NodeView(node: node)
                            .focusable()
                            .onDeleteCommand {
                                if node.id != 0 {
                                    graph.deleteNode(withID: node.id)
                                }
                            }
                    }
                },
                contextMenuPosition: $contextMenuPosition
            )
            .overlayPreferenceValue(SocketAnchorKey.self) { anchors in
                EdgesView(
                    anchors: anchors,
                    geometryProxy: geo
                )
            }
            .contextMenu {
                ContextMenu(
                    initialPosition: contextMenuPosition,
                    editorMode: .Edit,
                )
            }
        }
    }
}

#Preview {
    @Previewable @State var ui = NodeUISettings()
    @Previewable @State var graph: Graph = {
        var g = Graph()
        g.addNode(ConstantNode())
        g.addNode(ConstantNode())
        g.addNode(BinOpNode())
        return g
    }()

    GraphCanvasView()
        .environment(graph)
        .environment(ui)
}
