//
//  Command.swift
//  Hamilton
//
//  Created by Milton Montiel on 29/11/25.
//

protocol Command {
    func execute(scene: HScene, deltaTime: Float)
}

struct MoveCameraCommand: Command {
    let position: SIMD3<Float>
    let rotation: SIMD3<Float>
    let speed: Float

    func execute(scene: HScene, deltaTime: Float) {
        let movementAmount = deltaTime
        scene.camera.position += movementAmount * position
        scene.camera.rotation += movementAmount * rotation
    }
}

extension MoveCameraCommand {
    static func forward(speed: Float = 5.0) -> MoveCameraCommand {
        return MoveCameraCommand(
            position: [0, 0, -speed],
            rotation: .zero,
            speed: speed
        )
    }

    static func backward(speed: Float = 5.0) -> MoveCameraCommand {
        return MoveCameraCommand(
            position: [0, 0, speed],
            rotation: .zero,
            speed: speed
        )
    }

    static func right(speed: Float = 5.0) -> MoveCameraCommand {
        return MoveCameraCommand(
            position: [speed, 0, 0],
            rotation: .zero,
            speed: speed
        )
    }

    static func left(speed: Float = 5.0) -> MoveCameraCommand {
        return MoveCameraCommand(
            position: [-speed, 0, 0],
            rotation: .zero,
            speed: speed
        )
    }

    static func rotateRight(speed: Float = 1.0) -> MoveCameraCommand {
        return MoveCameraCommand(
            position: .zero,
            rotation: [0, -speed, 0],
            speed: speed
        )
    }

    static func rotateLeft(speed: Float = 1.0) -> MoveCameraCommand {
        return MoveCameraCommand(
            position: .zero,
            rotation: [0, speed, 0],
            speed: speed
        )
    }

    static func rotateUp(speed: Float = 1.0) -> MoveCameraCommand {
        return MoveCameraCommand(
            position: .zero,
            rotation: [speed, 0, 0],
            speed: speed
        )
    }

    static func rotateDown(speed: Float = 1.0) -> MoveCameraCommand {
        return MoveCameraCommand(
            position: .zero,
            rotation: [-speed, 0, 0],
            speed: speed
        )
    }

}
