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
        return g
    }()

    var body: some View {
        UIController(graph: $graph, nodeUI: nodeUI)
            .focusable()
    }
}

#Preview {
    ContentView()
}
