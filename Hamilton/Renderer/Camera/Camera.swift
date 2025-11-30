//
//  Camera.swift
//  Hamilton
//
//  Created by Milton Montiel on 29/11/25.
//

import Foundation
import simd

protocol Camera: Transformable {
    var projectionMatrix: float4x4 { get }
    var viewMatrix: float4x4 { get }

    mutating func updateAspect(size: CGSize)
}
