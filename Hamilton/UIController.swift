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

    @State var editorMode: UIMode = .Edit
    @State var nodeUI: NodeUISettings
    @FocusState var focused: Bool

    var body: some View {
        ZStack {
            MetalView()
                .environment(graph)

            ScrollView([.horizontal, .vertical]) {
                GraphCanvas()
                    .frame(width: 2000, height: 2000)
                    .environment(graph)
            }
            .defaultScrollAnchor(UnitPoint(x: 0.5, y: 0.5))
            .opacity(editorMode == .Edit ? 1 : 0)

        }.environment(nodeUI)
            .focusable()
            .focused($focused)
            .onKeyPress(.escape) {
                editorMode = .Normal
                return .handled
            }
            .onKeyPress(keys: ["i"]) { _ in
                print(editorMode)
                editorMode = .Edit
                return .handled
            }
            .onAppear {
                focused = true
            }
            .focusEffectDisabled()
        
    }
}
