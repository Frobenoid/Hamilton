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

    @GestureState private var translation: CGSize = CGSize.zero
    @State private var offset: CGSize = .zero
    @State private var position: CGPoint = .zero
    @State private var isAligned = false

    // TODO: Complete this implementation.
    func isAlignedToGrid(at: CGPoint) -> Bool {
        let x = Int(at.x)
        let y = Int(at.y)
        return x % 30 == 0 || y % 30 == 0
    }

    func nodeSize() -> CGFloat {
        return
            CGFloat((node.inputs.count + node.outputs.count))
            * uiSettings.socketSectionSize + uiSettings.titleSize
    }

    var drag: some Gesture {
        DragGesture()
            .updating($translation) { drag, translation, _ in
                translation = drag.translation
            }
            .onChanged { gesture in
                isAligned = isAlignedToGrid(at: gesture.location)
            }
            .onEnded { drag in

                offset = CGSize(
                    width: offset.width + drag.translation.width,
                    height: offset.height + drag.translation.height
                )
            }
    }

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {

                Text("\(node.label)")
                    .font(.headline)
                    .padding(10)
                    .frame(height: uiSettings.titleSize)

                if !node.inputs.isEmpty {
                    Divider()

                    ForEach(node.inputs, id: \.id) { input in
                        InputView(input: input)
                    }
                }

                if !node.outputs.isEmpty {
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
        .sensoryFeedback(.alignment, trigger: isAligned) { oldValue, newValue in
            !oldValue && newValue
        }
        .frame(
            idealWidth: uiSettings.minWidth,
            maxWidth: uiSettings.maxWidth
        )
        .frame(height: nodeSize())
        .position(position)
        .offset(
            CGSize(
                width: offset.width + translation.width,
                height: offset.height + translation.height
            )
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
