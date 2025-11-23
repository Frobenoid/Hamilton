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
        }
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
