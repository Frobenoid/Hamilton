//
//  Gestures.swift
//  Hamilton
//
//  Created by Milton Montiel on 25/12/25.
//

import AppKit
import SwiftUI

struct CanvasScrollView: NSViewRepresentable {
    @Binding var cameraPosition: CGPoint

    class Coordinator: NSObject {
        var parent: CanvasScrollView
        var accumulatedScrollDeltaX: CGFloat = 0
        var accumulatedScrollDeltaY: CGFloat = 0

        init(parent: CanvasScrollView) {
            self.parent = parent
        }

        @objc func handleEvent(_ event: NSEvent) {
            if event.type == .scrollWheel {
                accumulatedScrollDeltaX += event.scrollingDeltaX
                accumulatedScrollDeltaY += event.scrollingDeltaY

                parent.cameraPosition.x += event.scrollingDeltaX
                parent.cameraPosition.y += event.scrollingDeltaY

                print(
                    "(X: \(event.scrollingDeltaX), Y: \(event.scrollingDeltaY))"
                )
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeNSView(context: Context) -> NSView {
        let view = NSView()

        NSEvent.addLocalMonitorForEvents(matching: [.scrollWheel]) { event in
            context.coordinator.handleEvent(event)
            return event
        }

        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
    }
}

struct EventView: NSViewRepresentable {
    @Binding var message: String
    @Binding var position: CGPoint

    class Coordinator: NSObject {
        var parent: EventView
        var accumulatedScrollDeltaX: CGFloat = 0
        var accumulatedScrollDeltaY: CGFloat = 0

        init(parent: EventView) {
            self.parent = parent
        }

        @objc func handleEvent(_ event: NSEvent) {
            if event.type == .scrollWheel {
                accumulatedScrollDeltaX += event.scrollingDeltaX
                accumulatedScrollDeltaY += event.scrollingDeltaY

                parent.position.x += event.scrollingDeltaX
                parent.position.y += event.scrollingDeltaY

                print(
                    "(X: \(event.scrollingDeltaX), Y: \(event.scrollingDeltaY))"
                )
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeNSView(context: Context) -> NSView {
        let view = NSView()

        NSEvent.addLocalMonitorForEvents(matching: [.scrollWheel]) { event in
            context.coordinator.handleEvent(event)
            return event
        }

        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
    }
}

struct Test: View {
    @State private var message = "Swipe right to reveal"
    @State private var position = CGPoint(x: 0, y: 0)

    var body: some View {
        VStack {
            Text("(\(position.x), \(position.y))")
                .padding()
                .background(Color.orange)

            EventView(message: $message, position: $position)
                .frame(height: 200)  // Area to capture events
                .background(Color.gray)
                .position(position)
        }
        .padding()
    }
}

#Preview {
    Test()
}
