//
//  DraggableData.swift
//  Hamilton
//
//  Created by Milton Montiel on 23/11/25.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct DraggableData: Codable {
    let sourceSocket: SocketID
    let sourceNode: NodeID
}

extension DraggableData: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .draggableData)
    }
}

extension UTType {
    static var draggableData: UTType {
        UTType(exportedAs: "com.frobenoid.draggableData")
    }
}
