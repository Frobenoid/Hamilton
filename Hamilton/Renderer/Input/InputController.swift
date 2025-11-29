//
//  InputController.swift
//  Hamilton
//
//  Created by Milton Montiel on 28/11/25.
//

import GameController

class InputController {
    struct Point {
        var x: Float
        var y: Float
        static let zero = Point(x: 0, y: 0)
    }

    static let sharedController = InputController()

    var pressedKeys: Set<GCKeyCode> = []
    /// Tracking left-click.
    var leftMouseDown = false
    /// Movement since the last tracked movement.
    var mouseDelta: Point = .zero
    /// Mouse scroll
    var mouseScroll: Point = .zero

    private init() {
        let notificationCenter = NotificationCenter.default

        // Keyboard handling.
        notificationCenter
            .addObserver(
                forName: .GCKeyboardDidConnect,
                object: nil,
                queue: nil
            ) { notification in

                guard
                    let
                        keyboard = notification.object as? GCKeyboard
                else {
                    return
                }

                keyboard.keyboardInput?.keyChangedHandler = {
                    _,
                    _,
                    keyCode,
                    pressed in

                    if pressed {
                        self.pressedKeys.insert(keyCode)
                    } else {
                        self.pressedKeys.remove(keyCode)
                    }
                }

            }
    }
}
