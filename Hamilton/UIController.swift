//
//  UIController.swift
//  Hamilton
//
//  Created by Milton Montiel on 29/11/25.
//

import Foundation
import SwiftUI

struct UIController: View {
    @Binding var graph: Graph

    @State var editorMode: EditorMode = .Edit
    @State var nodeUI: NodeUISettings
    @FocusState var focused: Bool

    var body: some View {
        ZStack {
            MetalView()

            GraphCanvasView()
                .opacity(editorMode == .Edit ? 1 : 0)

            VStack {
                Spacer()
                HStack {
                    EditorModeView(editorMode: editorMode)
                    Spacer()
                }
            }
        }
        .environment(nodeUI)
        .environment(graph)
        .focusable()
        .focused($focused)
        .onKeyPress(.escape) {
            editorMode = .Normal
            return .handled
        }
        .onKeyPress(keys: ["i"]) { _ in
            editorMode = .Edit
            return .handled
        }
        .onAppear {
            focused = true
        }
        .focusEffectDisabled()
        .contextMenu {
            ContextMenu(editorMode: editorMode)
                .environment(graph)
        }
    }
}
