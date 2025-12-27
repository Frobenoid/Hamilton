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
        
        var node = Node()
        node.type = OutputNode()
        var d = ParameterBuilder()
        node.type.declare(&d)
        d.build(node: &node)

        g.addNode(node)
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
