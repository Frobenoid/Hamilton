//
//  Socket.swift
//  Hamilton
//
//  Created by Milton Montiel on 15/11/25.
//

import Foundation

protocol Socket {
    associatedtype S
    
    var currentValue: S? {get}
    var defaultValue: S? {get}
    
    /// Used to construct the socket.
    func withDefaultValue(_ defaultValue: S) -> Self
    
    /// Id inside parent node.
    var id: SocketID {get set}
    
    /// Tries to cast from `Any` to `T`.
    func setUntypedCurrentValue(to value: Any) throws(GraphError)
    /// Returns the current value wrapped by the input.
    func untypedCurrentValue() -> Any?
    /// Sets the current value to the default one, which could be null.
    func restoreToDefaultValue()
}

class Input<T>: Socket {
    var id: SocketID = -1
    var defaultValue: T?
    var currentValue: T?
    
    var isConnected: Bool = false
    
    func withDefaultValue(_ defaultValue: T) -> Self {
        self.defaultValue = defaultValue
        return self
    }

    func setUntypedCurrentValue(to value: Any) throws(GraphError) {
        if let newValue = value as? T {
            self.currentValue = newValue
        } else {
            throw(GraphError.imposibleCasting(from: value.self, to: T.self))
        }
    }
    
    func untypedCurrentValue() -> Any? {
        return currentValue
    }
    
    func restoreToDefaultValue() {
        currentValue = defaultValue
    }
}

class Output<T>: Socket {
    var id: SocketID = -1
    var defaultValue: T?
    var currentValue: T?
    
    func withDefaultValue(_ defaultValue: T) -> Self {
        self.defaultValue = defaultValue
        return self
    }

    func setUntypedCurrentValue(to value: Any) throws(GraphError) {
        if let newValue = value as? T {
            self.currentValue = newValue
        } else {
            throw(GraphError.imposibleCasting(from: value.self, to: T.self))
        }
    }
    
    func untypedCurrentValue() -> Any? {
        return currentValue
    }
    
    func restoreToDefaultValue() {
        currentValue = defaultValue
    }

}
