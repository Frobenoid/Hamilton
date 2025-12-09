//
//  Transform.swift
//  Hamilton
//
//  Created by Milton Montiel on 29/11/25.
//

import Foundation
import simd

struct Transform {
    var position: SIMD3<Float> = .zero
    var rotation: SIMD3<Float> = .zero
    var scale: Float = 1

    var forward: SIMD3<Float> {
        normalize([sin(rotation.y), 0, cos(rotation.y)])
    }

    var right: SIMD3<Float> {
        [forward.z, 0, -forward.x]
    }

}

extension Transform {
    var modelMatrix: matrix_float4x4 {
        let translation = float4x4(translation: position)
        let rotation = float4x4(rotation: rotation)
        let scale = float4x4(scale: scale)
        let modelMatrix = translation * rotation * scale
        return modelMatrix
    }
}

protocol Transformable {
    var transform: Transform { get set }
}

extension Transformable {
    var position: SIMD3<Float> {
        get { transform.position }
        set { transform.position = newValue }
    }

    var rotation: SIMD3<Float> {
        get { transform.rotation }
        set { transform.rotation = newValue }
    }

    var scale: Float {
        get { transform.scale }
        set { transform.scale = newValue }
    }
}
