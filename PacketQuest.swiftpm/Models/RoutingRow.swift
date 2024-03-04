//
//  File.swift
//  
//
//  Created by Ohara Yoji on 2024/02/25.
//

import Foundation

struct RoutingRow: Identifiable {
    let id: UUID = .init()
    var destinationNetwork: IPv4
    var nexthop: IPv4
}
