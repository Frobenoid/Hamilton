//
//  TSocket.swift
//  Hamilton
//
//  Created by Milton Montiel on 19/11/25.
//

import Foundation

class AnySocket<T> {
    var currentValue: T?
    var defaultValue: T?

    func withDefaultValue(_ defaultValue: T) -> Self {
        self.defaultValue = defaultValue
        return self
    }

}

class AnyInput<T>: AnySocket<T> {
    var isConnected: Bool = false
}

class AnyOutput<T>: AnySocket<T> {
}
