//
//  SIMD.swift
//  Hamilton
//
//  Created by Milton Montiel on 29/11/25.
//

import Foundation
import simd

extension float4x4 {
    /// Creates a 4x4 matrix that encodes a translation to the
    /// provided vector in R^3.
    init(translation position: SIMD3<Float>) {
        var matrix: float4x4 = matrix_identity_float4x4
        matrix.columns.3 = SIMD4<Float>(position.x, position.y, position.z, 1.0)
        self = matrix
    }

    init(rotationX amount: Float) {
        var matrix: float4x4 = matrix_identity_float4x4
        matrix.columns.1 = [0.0, cos(amount), sin(amount), 0.0]
        matrix.columns.2 = [0.0, -sin(amount), cos(amount), 0.0]
        self = matrix
    }

    init(rotationY amount: Float) {
        var matrix: float4x4 = matrix_identity_float4x4
        matrix.columns.0 = [cos(amount), 0, -sin(amount), 0]
        matrix.columns.2 = [sin(amount), 0, cos(amount), 0]
        self = matrix
    }

    init(rotationZ amount: Float) {
        var matrix: float4x4 = matrix_identity_float4x4
        matrix.columns.0 = [cos(amount), sin(amount), 0, 0]
        matrix.columns.1 = [-sin(amount), cos(amount), 0, 0]
        self = matrix
    }

    init(rotation angles: SIMD3<Float>) {
        let xRotation: float4x4 = .init(rotationX: angles.x)
        let yRotation: float4x4 = .init(rotationY: angles.y)
        let zRotation: float4x4 = .init(rotationZ: angles.z)

        self = xRotation * yRotation * zRotation
    }
}
