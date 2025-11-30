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

    public func commands() -> [any Command] {
        var commands: [any Command] = []

        if pressedKeys.contains(.keyW) {
            commands.append(MoveCameraCommand.forward())
        }

        if pressedKeys.contains(.keyS) {
            commands.append(MoveCameraCommand.backward())
        }

        if pressedKeys.contains(.keyD) {
            commands.append(MoveCameraCommand.right())
        }

        if pressedKeys.contains(.keyA) {
            commands.append(MoveCameraCommand.left())
        }

        if pressedKeys.contains(.rightArrow) {
            commands.append(MoveCameraCommand.rotateRight())
        }

        if pressedKeys.contains(.leftArrow) {
            commands.append(MoveCameraCommand.rotateLeft())
        }

        if pressedKeys.contains(.upArrow) {
            commands.append(MoveCameraCommand.rotateUp())
        }

        if pressedKeys.contains(.downArrow) {
            commands.append(MoveCameraCommand.rotateDown())
        }
        
        return commands

    }

}
