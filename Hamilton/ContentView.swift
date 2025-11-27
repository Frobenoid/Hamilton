//
//  ContentView.swift
//  Hamilton
//
//  Created by Milton Montiel on 15/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var nodeUI = NodeUISettings()
    @State private var graph = {
        var g = Graph()
        g.addNode(OutputNode())
        g.addNode(PrimitiveNode())
        g.addNode(BinOpNode())
        g.addNode(ConstantNode())
        g.addNode(ConstantNode())
        g.addNode(VectorNode())
        
        return g
    }()

    var body: some View {
        ZStack {
            MetalView().environment(graph)
            ScrollView([.horizontal, .vertical]) {
                GraphCanvas()
                    .frame(width: 2000, height: 2000)
                    .allowsHitTesting(true)
                    .environment(graph)
                    .focusable(false)
            }
            .defaultScrollAnchor(UnitPoint(x: 0.5, y: 0.5))

        }.environment(nodeUI)
    }
}

#Preview {
    ContentView()
}
