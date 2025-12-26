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
    @Binding var contextMenuPosition: CGPoint
    var viewHeight: Double

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
            }

            if event.type == .rightMouseDown {
                parent.contextMenuPosition.x =
                    event.locationInWindow.x + parent.cameraPosition.x
                parent.contextMenuPosition.y =
                    -event.locationInWindow.y + parent.viewHeight
                    + parent.cameraPosition.y
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeNSView(context: Context) -> NSView {
        let view = NSView()

        NSEvent.addLocalMonitorForEvents(matching: [
            .scrollWheel, .rightMouseDown,
        ]) { event in
            context.coordinator.handleEvent(event)
            return event
        }

        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        context.coordinator.parent.viewHeight = viewHeight
    }
}
