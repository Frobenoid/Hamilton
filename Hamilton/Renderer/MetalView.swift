//
//  MetalView.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import MetalKit
import SwiftUI

struct MetalView: View {
    @Binding var scene: HScene
    @State private var metalView = MTKView()
    @State private var controller: Controller?

    var body: some View {
        MetalViewRepresentable(metalView: $metalView)
            .onAppear {
                controller = Controller(metalView: metalView, scene: $scene)
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

#Preview {
    @Previewable @State var scene = HScene()

    VStack {
        Text("Metal View")
        MetalView(scene: $scene)
    }
}
