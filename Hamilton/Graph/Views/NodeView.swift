//
//  NodeView.swift
//  Hamilton
//
//  Created by Milton Montiel on 23/11/25.
//

import SwiftUI

struct NodeView: View {
    let node: Node

    let uiSettings = NodeUISettings()
    @State private var offset = CGSize.zero
    @GestureState private var dragOffset: CGSize = .zero
    @State private var isDragging = false
    @State private var isSelected = false

    func nodeSize() -> CGFloat {
        return
            CGFloat((node.inputs.count + node.outputs.count))
            * uiSettings.socketSectionSize + uiSettings.titleSize
    }

    var drag: some Gesture {
        DragGesture(minimumDistance: 3)
            .updating($dragOffset) { value, state, _ in
                state = value.translation
                node.isDragging = true
            }
            .onEnded {
                value in

                offset.width += value.translation.width
                offset.height += value.translation.height
            }
    }

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {

                Text("\(node.label)")
                    .font(.headline)
                    .padding(10)
                    .frame(height: uiSettings.titleSize)

                if node.inputs.count > 0 {
                    Divider()

                    ForEach(node.inputs, id: \.id) { input in
                        InputView(input: input)
                    }
                }
                if node.outputs.count > 0 {
                    Divider()

                    ForEach(node.outputs, id: \.id) { output in
                        OutputView(output: output)
                    }
                }

                Divider()

                Spacer()
            }
        }
        .background(Color.background)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray.opacity(0.2), lineWidth: 1)
        )
        .frame(
            minWidth: uiSettings.minWidth,
            idealWidth: uiSettings.minWidth,
            maxWidth: uiSettings.maxWidth
        )
        .frame(height: nodeSize())
        .offset(
            self.node.isDragging
                ? CGSize(
                    width: offset.width + dragOffset.width,
                    height: offset.height + dragOffset.height
                ) : node.offset

        )
        .gesture(drag)
    }
}

#Preview {
    @Previewable @State var graph = {
        var g = Graph()
        g.addNode(PrimitiveNode())
        g.addNode(BinOpNode())
        return g
    }()

    @Previewable @State var settings = NodeUISettings()

    NodeView(node: graph.nodes[1]).environment(graph).padding(10)
        .environment(settings)
    NodeView(node: graph.nodes[0]).environment(graph).padding(10)
        .environment(settings)
}
