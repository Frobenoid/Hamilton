//
//  NodeView.swift
//  Hamilton
//
//  Created by Milton Montiel on 23/11/25.
//

import SwiftUI

struct NodeView: View {
    let node: Node

    @State private var offset = CGSize.zero
    @GestureState private var dragOffset: CGSize = .zero
    @State private var isDragging = false
    @State private var isSelected = false

    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()

                Text("\(node.label)")
                    .font(.headline)

                Spacer()

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
        .background()
        .frame(width: 200, height: 170)
        .offset(
            self.node.isDragging
                ? CGSize(
                    width: offset.width + dragOffset.width,
                    height: offset.height + dragOffset.height
                ) : node.offset

        )
        .gesture(
            DragGesture(minimumDistance: 3)
                .updating($dragOffset) { value, state, _ in
                    state = value.translation
                    node.isDragging = true
                    node.offset = offset + dragOffset
                }
                .onEnded {
                    value in

                    offset.width += value.translation.width
                    offset.height += value.translation.height
                    node.offset = offset
                    node.isDragging = false
                }
        )
    }
}

#Preview {
    @Previewable @State var graph = {
        var g = Graph()
        g.addNode(BinOpNode())
        return g
    }()

    NodeView(node: graph.nodes[0])
}
