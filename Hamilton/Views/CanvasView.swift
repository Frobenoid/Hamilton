//
//  GraphView.swift
//  Hamilton
//
//  Created by Milton Montiel on 19/12/25.
//

import SwiftUI

struct CanvasCamera {
    var position: CGPoint = .zero
    // This should be in a defined range.
    var scale: CGFloat = 1
}

/// This view creates a scrollable and pinchable canvas.
///
/// This tracks:
/// 1. Right click position.
/// 2. Panning.
/// 3. Zooming.
///
struct CanvasView<Content: View>: View {

    @ViewBuilder let content: Content
    @State var camera = CanvasCamera()
    @Binding var contextMenuPosition: CGPoint

    // TODO: Move this into a settings struct.
    var scalingFactor: CGFloat = 0.5

    var magnification: some Gesture {
        MagnifyGesture()
            .onChanged { gesture in
                camera.scale = max(
                    min(gesture.magnification * scalingFactor, 1),
                    0.2
                )
            }
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Text("Camera: \(camera.position)")
                CanvasScrollView(
                    cameraPosition: $camera.position,
                    contextMenuPosition: $contextMenuPosition,
                    viewHeight: geo.size.height
                )
                .gesture(magnification)

                content
                    .offset(
                        x: camera.position.x,
                        y: camera.position.y
                    )
                    .scaleEffect(
                        camera.scale,
                        anchor: .center
                    )
            }
        }
    }
}

struct SubViewTest: View {
    @State var position: CGPoint = .zero
    @State var isSelected: Bool = false

    // TODO: Implement selection!
    var tap: some Gesture {
        SpatialTapGesture()
            .onEnded { event in
                self.isSelected.toggle()
            }
    }

    var drag: some Gesture {
        DragGesture()
            .onChanged { gesture in
                position = CGPoint(
                    x: position.x + gesture.translation.width,
                    y: position.y + gesture.translation.height
                )
            }
    }

    var body: some View {
        Circle()
            .fill(Color.blue)
            //            .gesture(tap)
            .gesture(drag)
            .position(position)
    }
}

#Preview {
    @Previewable @State var contextMenuPosition: CGPoint = .zero
    CanvasView(
        content: {
            ForEach(0..<10) {
                i in
                SubViewTest()
            }
        },
        contextMenuPosition: $contextMenuPosition
    )
}
