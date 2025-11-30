//
//  FirstPerson.swift
//  Hamilton
//
//  Created by Milton Montiel on 29/11/25.
//

import Foundation
import ModelIO
import simd

struct FirstPerson: Camera {
    var camera: MDLCamera

    var projectionMatrix: float4x4 {
        camera.projectionMatrix
    }

    var aspect: Float {
        camera.sensorAspect
    }

    var viewMatrix: float4x4 {
        (float4x4(translation: position) * float4x4(rotation: rotation)).inverse
    }

    var transform: Transform = Transform()

    init(
        fov: Float = 45.0,
        aspect: Float = 1.0,
        near: Float = 0.1,
        far: Float = 100.0
    ) {
        camera = MDLCamera()
        camera.nearVisibilityDistance = near
        camera.farVisibilityDistance = far
        camera.fieldOfView = fov
        transform.position = [0, 0, 5]
    }

    mutating func updateAspect(size: CGSize) {
        camera.sensorAspect = Float(size.width / size.height)
    }

    mutating func update(deltaTime: Float) {

    }

}
