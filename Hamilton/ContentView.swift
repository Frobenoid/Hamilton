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
        g.addNode(ConstantNode())
        g.addNode(ConstantNode())
        g.addNode(BinOpNode())
        g.addNode(PrimitiveNode())

        return g
    }()

    @State private var scene = HScene()

    var body: some View {
        ZStack {
            MetalView(scene: $scene)
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
