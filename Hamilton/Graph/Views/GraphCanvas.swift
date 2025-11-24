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
                    let source = anchors[
                        SocketAnchor(
                            nodeID: edge.sourceNode,
                            socketID: edge.sourceSocket,
                            isOutput: true
                        )
                    ]!

                    let destination = anchors[
                        SocketAnchor(
                            nodeID: edge.destinationNode,
                            socketID: edge.destinationSocket
                        )
                    ]!

                    let start = geo[source]
                    let end = geo[destination]

                    let path = self.computePath(start: start, end: end)

                    path
                        .stroke(
                            Color.black.opacity(0.8),
                            style: StrokeStyle(
                                lineWidth: 5,
                                lineCap: .round,
                                lineJoin: .round,
                            )
                        )
                        .contentShape(
                            path.strokedPath(StrokeStyle(lineWidth: 15))
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

    private func computePath(start: CGPoint, end: CGPoint) -> Path {
        let stemHeight: CGFloat = self.clamp(
            abs(end.y - start.y) / 4.0,
            lowerBound: 5.0,
            upperBound: 35.0
        )
        let stemOffset: CGFloat = self.clamp(
            self.dist(p1: start, p2: end) / 4.0,
            lowerBound: 5.0,
            upperBound: 35.0
        ) /*min( max(5, self.dist(p1: start, p2:end)), 40 )*/

        let start1: CGPoint = CGPoint(
            x: start.x + stemHeight,
            y: start.y
        )

        let end1: CGPoint = CGPoint(
            x: end.x - stemHeight,
            y: end.y
        )

        let controlOffset: CGFloat = max(
            stemHeight + stemOffset,
            abs(end1.y - start1.y) / 2.4
        )
        let control1 = CGPoint(x: start1.x + controlOffset, y: start1.y)
        let control2 = CGPoint(x: end1.x - controlOffset, y: end1.y)

        return
            Path { path in
                path.move(to: start)
                path.addLine(to: start1)
                path.addCurve(to: end1, control1: control1, control2: control2)
                path.addLine(to: end)
            }
    }

    private func clamp(_ x: CGFloat, lowerBound: CGFloat, upperBound: CGFloat)
        -> CGFloat
    {
        return max(min(x, upperBound), lowerBound)
    }

    private func dist(p1: CGPoint, p2: CGPoint) -> CGFloat {
        let distance = hypot(p1.x - p2.x, p1.y - p2.y)
        return distance
    }
}

#Preview {
    @Previewable @State var graph: Graph = {
        var g = Graph()

        g.addNode(ConstantNode())
        g.addNode(ConstantNode())
        g.addNode(BinOpNode())
        return g
    }()

    GraphCanvas().environment(graph)

}
