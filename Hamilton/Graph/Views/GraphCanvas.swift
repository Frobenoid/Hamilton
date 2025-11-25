//
//  GraphCanvas.swift
//  Hamilton
//
//  Created by Milton Montiel on 23/11/25.
//

import SwiftUI

struct GraphCanvas: View {
    @Environment(Graph.self) var graph: Graph
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(graph.nodes, id: \.id) { node in
                    NodeView(node: node)
                }
            }
            .offset(geo.size / 2)
            .coordinateSpace(name: "Graph")
            .overlayPreferenceValue(SocketAnchorKey.self) { anchors in

                ForEach(graph.edges, id: \.id) { edge in

                    if let
                        source = anchors[
                            SocketAnchor(
                                nodeID: edge.sourceNode,
                                socketID: edge.sourceSocket,
                                isOutput: true
                            )
                        ],

                        let destination = anchors[
                            SocketAnchor(
                                nodeID: edge.destinationNode,
                                socketID: edge.destinationSocket
                            )
                        ]
                    {
                        let start = geo[source]
                        let end = geo[destination]

                        EdgeShape(start: start, end: end)
                            .stroke(
                                Color.black.opacity(0.8),
                                style: StrokeStyle(
                                    lineWidth: 5,
                                    lineCap: .round,
                                    lineJoin: .round
                                )
                            )
                            .gesture(
                                TapGesture(count: 2).onEnded({
                                    _ in
                                    graph.disconnect(edge.id)
                                    try! Evaluator(graph: graph).evaluate()
                                })
                            )
                    }

                }
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

    GraphCanvas().environment(graph).environment(ui)

}
