//
//  ContextMenu.swift
//  Hamilton
//
//  Created by Milton Montiel on 30/11/25.
//

import SwiftUI


struct ContextMenu: View {
    @Environment(Graph.self) var graph
    var initialPosition: CGPoint = .zero

    var editorMode: EditorMode
    var body: some View {
        if editorMode == .Edit {
        }
    }
}

#Preview {
    @Previewable @State var graph = Graph()
    ContextMenu(editorMode: .Edit).environment(graph)
    ContextMenu(editorMode: .Normal).environment(graph)
}
