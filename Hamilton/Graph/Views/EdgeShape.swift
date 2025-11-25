//
//  EdgeShape.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import SwiftUI

struct EdgeShape: Shape {
    var start: CGPoint
    var end: CGPoint

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let deltaY = abs(end.y - start.y)
        let distance = hypot(end.x - start.x, end.y - start.y)

        // Determine handle length based on distance
        let stemHeight = clamp(
            deltaY / 4.0,
            lowerBound: 5.0,
            upperBound: 35.0
        )

        let stemOffset = clamp(
            distance / 4.0,
            lowerBound: 5.0,
            upperBound: 35.0
        )

        let start1 = CGPoint(x: start.x + stemHeight, y: start.y)
        let end1 = CGPoint(x: end.x - stemHeight, y: end.y)

        let controlOffset = max(
            stemHeight + stemOffset,
            abs(end1.y - start1.y) / 2.4
        )

        let control1 = CGPoint(x: start1.x + controlOffset, y: start1.y)
        let control2 = CGPoint(x: end1.x - controlOffset, y: end1.y)

        path.move(to: start)
        path.addLine(to: start1)
        path.addCurve(to: end1, control1: control1, control2: control2)
        path.addLine(to: end)

        return path
    }

    private func clamp(_ x: CGFloat, lowerBound: CGFloat, upperBound: CGFloat)
        -> CGFloat
    {
        return max(min(x, upperBound), lowerBound)
    }

    var animatableData:
        AnimatablePair<CGPoint.AnimatableData, CGPoint.AnimatableData>
    {
        get { AnimatablePair(start.animatableData, end.animatableData) }
        set {
            start.animatableData = newValue.first
            end.animatableData = newValue.second
        }
    }
}
