//
//  File.swift
//  
//
//  Created by Ohara Yoji on 2024/02/25.
//

import Foundation

struct Router: Identifiable {
    let id: UUID = .init()
    var ports: [String: IPv4]
    var routingTable: RoutingTable

    init(ports: [String: IPv4], routingTable: RoutingTable) {
        self.ports = ports
        self.routingTable = routingTable
    }
}
