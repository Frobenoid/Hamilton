//
//  GraphMenu.swift
//  Hamilton
//
//  Created by Milton Montiel on 27/12/25.
//

import SwiftUI

struct GraphViewMenu: View {
    @Environment(Graph.self) var graph
    var position: CGPoint

    var body: some View {
        Text("Add")
            .font(.headline)
            .bold()
        // TODO: Instead of calling methods directly into
        // TODO: the graph this should add them into a dispatch queue.
        Menu {
            Button {
                graph.addNode(ConstantNode())
            } label: {
                Image(systemName: "number")
                Text("Constant")
            }

            Button {
                graph.addNode(BinOpNode())
            } label: {
                Image(systemName: "sum")
                Text("Binary Operation")
            }

            Button {
                graph.addNode(VectorNode())
            } label: {
                Image(systemName: "curlybraces")
                Text("Vector")
            }

            Button {
                // TODO: Refactor node creation to initialize incrementally.
                // GOAL:
                // let node = Node()
                // ... switch ...
                // node.type = UIntVectorNode.Self
                // node.initialPosition = initialPosition
                // context.addCommand(AddNode(node))
                let node = UIntVectorNode()
                node.initialPosition = position

                graph.addNode(node)
            } label: {
                Image(systemName: "curlybraces")
                Text("UInt Vector")
            }

        } label: {
            Image(systemName: "sum")
            Text("Math")
        }

        Button {
            graph.addNode(PrimitiveNode())
        } label: {
            Image(systemName: "rotate.3d")
            Text("Primitive")
        }

        Button {
            graph.addNode(SubdivisionNode())
        } label: {
            Image(systemName: "rotate.3d")
            Text("Subdivision")
        }

        Button {
            graph.addNode(TimeNode())
        } label: {
            Image(systemName: "timer")
            Text("Time")
        }

        Button {
            graph.addNode(WaveNode())
        } label: {
            Image(systemName: "waveform.path")
            Text("Wave")
        }

        Button {
            graph.addNode(TransformNode())
        } label: {
            Image(systemName: "move.3d")
            Text("Transform")
        }
    }
}
