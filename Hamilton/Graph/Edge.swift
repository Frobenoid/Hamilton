//
//  Edge.swift
//  Hamilton
//
//  Created by Milton Montiel on 15/11/25.
//

import Foundation

class Edge {
    // Index inside parent edges.
    var id: EdgeID = -1

    // This is mutable since deletion of a node may
    // required to shift a node index and thus all the
    // incoming/outgoing edges need to be updated
    // to follow such index.
    var sourceNode: NodeID
    var destinationNode: NodeID

    let sourceSocket: SocketID
    let destinationSocket: SocketID

    init(
        sourceNode: NodeID,
        sourceSocket: SocketID,
        destinationNode: NodeID,
        destinationSocket: SocketID
    ) {
        self.sourceNode = sourceNode
        self.destinationNode = destinationNode
        self.sourceSocket = sourceSocket
        self.destinationSocket = destinationSocket
    }
}
