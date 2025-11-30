//
//  Tranform.swift
//  Hamilton
//
//  Created by Milton Montiel on 29/11/25.
//

import Foundation
import simd

struct Transform {
    var positon: SIMD3<Float> = .zero
    var rotation: SIMD3<Float> = .zero
    var scale: Float = 1

    var modelMatrix: float4x4 {
        let translation = float4x4(translation: positon)
        // TODO: Rotation
        // TODO: Scaling
        return translation
    }
}

protocol Transformable {
    var transform: Transform { get set }
}

extension Transformable {
    var position: SIMD3<Float> {
        get { transform.positon }
        set { transform.positon = newValue }
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
