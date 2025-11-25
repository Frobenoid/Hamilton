//
//  MetalView.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import MetalKit
import SwiftUI

struct MetalView: View {
    @Environment(Graph.self) var graph
    @State var scene: HScene?
    @State private var metalView = MTKView()
    @State private var controller: Controller?

    var body: some View {
        MetalViewRepresentable(metalView: $metalView)
            .onAppear {
                scene = HScene(graph: graph)
                
                if let scene = Binding($scene) {
                    controller = Controller(metalView: metalView, scene: scene)
                }
            }
    }
}

struct MetalViewRepresentable: NSViewRepresentable {
    @Binding var metalView: MTKView

    func makeNSView(context: Context) -> NSView {
        metalView
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        updateMetalView()
    }

    func updateMetalView() {

    }
}

//#Preview {
//    @Previewable @State var graph = Graph()
//    @Previewable @State var scene = HScene(graph: $graph)
//
//    VStack {
//        Text("Metal View")
//        MetalView(scene: $scene)
//    }
//}
