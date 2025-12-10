//
//  NodeUISettings.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import Foundation

@Observable
class NodeUISettings {
    public var titleSize: CGFloat = 30
    public var socketSectionSize: CGFloat = 35
    public var widthFraction: CGFloat = 11
    public var minWidth: CGFloat = 200
    public var maxWidth: CGFloat = 390
    public var socketPinSize: CGFloat = 20
    
    public func length(total: CGFloat, _ l: CGFloat) -> CGFloat {
        return total * (l / widthFraction)
    }
}
