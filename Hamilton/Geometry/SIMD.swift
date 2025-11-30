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
}
