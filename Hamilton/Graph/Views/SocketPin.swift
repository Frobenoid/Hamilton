//
//  SocketPin.swift
//  Hamilton
//
//  Created by Milton Montiel on 24/11/25.
//

import SwiftUI

struct SocketPin: View {
    @Environment(NodeUISettings.self) var ui
    
    var body: some View {
        Circle()
            .fill(Color.blue)
            .frame(width: ui.socketPinSize)
    }
}

