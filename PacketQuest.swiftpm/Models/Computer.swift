//
//  File.swift
//  
//
//  Created by Ohara Yoji on 2024/02/25.
//

import Foundation

struct Computer: Node, Identifiable {
    let id: UUID = .init()
    var IPv4: IPv4
    var routingTable: RoutingTable
    var connected: [Node]

    init(IPv4: IPv4, routingTable: RoutingTable, connected: [Node]) {
        self.IPv4 = IPv4
        self.routingTable = routingTable
        self.connected = connected
    }
}
