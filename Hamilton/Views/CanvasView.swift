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

struct CanvasView<Content: View>: View {

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    @State var camera = CanvasCamera()
    /// Tap location in world coordinates
    @State var tapLocation = CGPoint.zero

    // TODO: Move this into a settings struct.
    var scalingFactor: CGFloat = 0.5
    var translationFactor: CGFloat {
        1 / (camera.scale * 10)
    }

    var magnification: some Gesture {
        MagnifyGesture()
            .onChanged { gesture in
                camera.scale = max(
                    min(gesture.magnification * scalingFactor, 1),
                    0.2
                )
            }
    }

    var drag: some Gesture {
        // TODO: Restrict velocity to avoid blow-ups.
        DragGesture()
            .onChanged { gesture in
                camera.position.x +=
                    gesture.predictedEndTranslation.width
                    * translationFactor
                camera.position.y +=
                    gesture.predictedEndTranslation.height
                    * translationFactor
            }
    }

    var tap: some Gesture {
        SpatialTapGesture()
            .onEnded { event in
                tapLocation = CGPoint(
                    x: event.location.x + camera.position.x,
                    y: event.location.y + camera.position.y
                )
            }
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {

                Color.clear
                    .contentShape(Rectangle())
                    .gesture(drag)
                    .gesture(magnification)
                    .gesture(tap)

                content
                    .offset(
                        CGSize(
                            width: camera.position.x,
                            height: camera.position.y
                        )
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
    CanvasView {
        ForEach(0..<10) {
            i in
            SubViewTest()
        }
    }
}
