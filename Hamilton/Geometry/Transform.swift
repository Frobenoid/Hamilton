//
//  Transform.swift
//  Hamilton
//
//  Created by Milton Montiel on 15/12/25.
//

import Foundation
import MetalKit

protocol Transformable {
    var transform: MDLTransform { get set }
}

extension Transformable {
    var position: SIMD3<Float> {
        get { transform.translation }
        set { transform.translation = newValue }
    }

    var rotation: SIMD3<Float> {
        get { transform.rotation }
        set { transform.rotation = newValue }
    }

    var scale: SIMD3<Float> {
        get { transform.scale }
        set { transform.scale = newValue }
    }
}

extension Transformable {
    var forward: SIMD3<Float> {
        normalize([sin(rotation.y), 0, cos(rotation.y)])
    }

    var right: SIMD3<Float> {
        [forward.z, 0, -forward.x]
    }
}
