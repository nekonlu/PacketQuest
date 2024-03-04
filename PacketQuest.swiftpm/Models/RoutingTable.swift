//
//  File.swift
//  
//
//  Created by Ohara Yoji on 2024/02/25.
//

import Foundation

struct RoutingTable: Identifiable {
    let id: UUID = .init()
    var table: [RoutingRow]
    init(table: [RoutingRow]) {
        self.table = table
    }
}
