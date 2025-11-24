//
//  ContentView.swift
//  Hamilton
//
//  Created by Milton Montiel on 15/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var graph = {
        var g = Graph()
        g.addNode(ConstantNode())
        g.addNode(ConstantNode())
        g.addNode(BinOpNode())
        g.addNode(PrimitiveNode())
        
        return g
    }()

    var body: some View {
        ZStack {
            ScrollView([.horizontal, .vertical]) {
                GraphCanvas()
                    .frame(width: 2000, height: 2000)
                    .allowsHitTesting(true)
                    .environment(graph)
            }
            .defaultScrollAnchor(UnitPoint(x: 0.5, y: 0.5))
        }
    }
}

#Preview {
    ContentView()
}
