//
//  GraphView.swift
//  Hamilton
//
//  Created by Milton Montiel on 19/12/25.
//

import SwiftUI

struct GraphCamera {
    var position: CGPoint = .zero
    // This should be in a defined range.
    var scale: CGFloat = 1
}

struct GraphView: View {
    @State var camera = GraphCamera()
    @State var circleOffset = CGPoint.zero
    /// Tap location in world coordinates
    @State var tapLocation = CGPoint.zero

    var translationFactor: CGFloat {
        1 / (camera.scale * 10)
    }
    var scalingFactor: CGFloat = 0.5

    var magnification: some Gesture {
        MagnifyGesture()
            .onChanged { gesture in
                // TODO: Make this smoother.
                camera.scale = max(
                    min(gesture.magnification * scalingFactor, 1),
                    0.3
                )
            }
    }

    var drag: some Gesture {
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
                Rectangle()
                    .gesture(drag)
                    .gesture(magnification)
                    .gesture(tap)
                ForEach(0..<10) {
                    i in
                    SubViewTest()
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
            .background(isSelected ? Color.red : nil)
            //            .gesture(tap)
            .gesture(drag)
            .position(position)

    }
}

#Preview {
    GraphView()
}
