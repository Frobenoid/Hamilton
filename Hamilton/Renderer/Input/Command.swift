//
//  Command.swift
//  Hamilton
//
//  Created by Milton Montiel on 29/11/25.
//

protocol Command {
    func execute(scene: HScene, deltaTime: Float)
}

struct AddNodeCommand: Command {

    let node: Node

    func execute(scene: HScene, deltaTime: Float) {
        scene.graph.addNode(node)
    }
}

struct MoveCameraCommand: Command {
    let position: SIMD3<Float>
    let rotation: SIMD3<Float>
    let speed: Float

    func execute(scene: HScene, deltaTime: Float) {
        let movementAmount = deltaTime
        scene.camera.position +=
            movementAmount
            * (position.z * scene.camera.forward + position.x
                * scene.camera.right)
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

    static func rotateRight(speed: Float = 2.0) -> MoveCameraCommand {
        return MoveCameraCommand(
            position: .zero,
            rotation: [0, -speed, 0],
            speed: speed
        )
    }

    static func rotateLeft(speed: Float = 2.0) -> MoveCameraCommand {
        return MoveCameraCommand(
            position: .zero,
            rotation: [0, speed, 0],
            speed: speed
        )
    }
}
