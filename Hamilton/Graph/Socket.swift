//
//  Socket.swift
//  Hamilton
//
//  Created by Milton Montiel on 15/11/25.
//

import Foundation
import SwiftUI

protocol Socket {
    associatedtype T

    /// Id inside parent node.
    var id: SocketID { get set }
    var parentID: NodeID { get set }
    var currentValue: T? { get }
    var defaultValue: T? { get }
    var isConnected: Bool { get set }
    var isUserModifiable: Bool { get }
    var label: String { get }

    /// Used to construct the socket.
    func withDefaultValue(_ defaultValue: T) -> Self

    func asUserModifiable() -> Self

    /// Tries to cast from `Any` to `T`.
    func setUntypedCurrentValue(to value: Any) throws(GraphError)
    /// Returns the current value wrapped by the input.
    func untypedCurrentValue() -> Any?
    /// Sets the current value to the default one, which could be null.
    func restoreToDefaultValue()

    /// Marks this as connected to another socket.
    func toggleConnection()
}

public struct SocketAnchorKey: PreferenceKey {
    public typealias Value = [SocketAnchor: Anchor<CGPoint>]
    public static var defaultValue: [SocketAnchor: Anchor<CGPoint>] = [:]

    public static func reduce(
        value: inout [SocketAnchor: Anchor<CGPoint>],
        nextValue: () -> [SocketAnchor: Anchor<CGPoint>]
    ) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

public struct SocketAnchor: Hashable {
    public let nodeID: NodeID
    public let socketID: SocketID
    public var isOutput: Bool = false
}

@Observable
class Output<T>: Socket {
    var id: SocketID = -1
    var parentID: NodeID = -1
    var defaultValue: T?
    var currentValue: T?
    var isConnected = false
    var isUserModifiable = false
    var label: String = ""

    func withDefaultValue(_ defaultValue: T) -> Self {
        self.defaultValue = defaultValue
        self.currentValue = defaultValue
        return self
    }

    func asUserModifiable() -> Self {
        isUserModifiable = true
        return self
    }

    func withLabel(_ newLabel: String) -> Self {
        label = newLabel
        return self
    }

    func setUntypedCurrentValue(to value: Any) throws(GraphError) {
        if let newValue = value as? T {
            self.currentValue = newValue
        } else {
            throw (GraphError.imposibleCasting(from: value.self, to: T.self))
        }
    }

    func untypedCurrentValue() -> Any? {
        return currentValue
    }

    func restoreToDefaultValue() {
        currentValue = defaultValue
    }

    func toggleConnection() {
        fatalError(
            "toggleConnection is not supposed to be called in an output socket"
        )
    }
}

class Input<T>: Output<T> {
    override func toggleConnection() {
        isConnected.toggle()
    }

}
