//
//  EdgesView.swift
//  Hamilton
//
//  Created by Milton Montiel on 25/12/25.
//
import SwiftUI

struct EdgesView: View {
    var anchors: SocketAnchorKey.Value
    var geometryProxy: GeometryProxy
    @Environment(Graph.self) var graph: Graph

    var body: some View {
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
                let start = geometryProxy[source]
                let end = geometryProxy[destination]

                EdgeShape(start: start, end: end)
                    .stroke(
                        Color.background.opacity(0.8),
                        style: StrokeStyle(
                            lineWidth: 5,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                    .contentShape(
                        EdgeShape(start: start, end: end)
                            .stroke(lineWidth: 15)
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
