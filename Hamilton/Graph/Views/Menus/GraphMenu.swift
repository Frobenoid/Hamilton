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
    @State var builder: NodeBuilder = .init()

    func addNode(_ nodeType: any NodeType) {
        let node = builder.build(ofType: nodeType)
        node.initialPosition = position
        graph.addNode(node)
    }

    var body: some View {
        Text("Add")
            .font(.headline)
            .bold()
        // TODO: Instead of calling methods directly into
        // TODO: the graph this should add them into a dispatch queue.
        Menu {
            Button {
                addNode(ConstantNode())
            } label: {
                Image(systemName: "number")
                Text("Constant")
            }

            Button {
                addNode(BinOpNode())
            } label: {
                Image(systemName: "sum")
                Text("Binary Operation")
            }

            Button {
                addNode(VectorNode())
            } label: {
                Image(systemName: "curlybraces")
                Text("Vector")
            }

            Button {

            } label: {
                Image(systemName: "curlybraces")
                Text("UInt Vector")
            }

        } label: {
            Image(systemName: "sum")
            Text("Math")
        }

        Button {
            addNode(PrimitiveNode())
        } label: {
            Image(systemName: "rotate.3d")
            Text("Primitive")
        }

        Button {
            //            graph.addNode(SubdivisionNode())
        } label: {
            Image(systemName: "rotate.3d")
            Text("Subdivision")
        }

        Button {
            //            graph.addNode(TimeNode())
        } label: {
            Image(systemName: "timer")
            Text("Time")
        }

        Button {
            //            graph.addNode(WaveNode())
        } label: {
            Image(systemName: "waveform.path")
            Text("Wave")
        }

        Button {
            //            graph.addNode(TransformNode())
        } label: {
            Image(systemName: "move.3d")
            Text("Transform")
        }
    }
}
