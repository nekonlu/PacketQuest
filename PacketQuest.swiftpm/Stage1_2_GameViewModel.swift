//
//  Stage1_2_GameViewModel.swift
//  PacketQuest
//
//  Created by Ohara Yoji on 2024/02/26.
//

import SwiftUI

class Stage1_2_GameViewModel: ObservableObject {
    @Published var computer: Computer = .init(
        IPv4: IPv4(
            address1octet: 192,
            address2octet: 168,
            address3octet: 1,
            address4octet: 1,
            subnet1octet: 255,
            subnet2octet: 255,
            subnet3octet: 255,
            subnet4octet: 0,
            CIDR: 24
        )!,
        routingTable: .init(
            table: [
                .init(
                    destinationNetwork: IPv4(
                        address1octet: 0,
                        address2octet: 0,
                        address3octet: 0,
                        address4octet: 0,
                        subnet1octet: 0,
                        subnet2octet: 0,
                        subnet3octet: 0,
                        subnet4octet: 0,
                        CIDR: 0
                    )!,
                    nexthop: IPv4(
                        address1octet: 0,
                        address2octet: 0,
                        address3octet: 0,
                        address4octet: 0,
                        subnet1octet: 0,
                        subnet2octet: 0,
                        subnet3octet: 0,
                        subnet4octet: 0,
                        CIDR: 0
                    )!
                )
            ]
        ),
        connected: []
    )

    @Published var router: Router = .init(
        ports: [
            "192.168.1.254/24": .init(
                address1octet: 192,
                address2octet: 168,
                address3octet: 1,
                address4octet: 254,
                subnet1octet: 255,
                subnet2octet: 255,
                subnet3octet: 255,
                subnet4octet: 0,
                CIDR: 24
            )!,
            "0.0.0.0/0": .init(
                address1octet: 0,
                address2octet: 0,
                address3octet: 0,
                address4octet: 0,
                subnet1octet: 0,
                subnet2octet: 0,
                subnet3octet: 0,
                subnet4octet: 0,
                CIDR: 0
            )!
        ],
        routingTable: .init(
            table: [
                .init(
                    destinationNetwork: IPv4(
                        address1octet: 0,
                        address2octet: 0,
                        address3octet: 0,
                        address4octet: 0,
                        subnet1octet: 0,
                        subnet2octet: 0,
                        subnet3octet: 0,
                        subnet4octet: 0,
                        CIDR: 0
                    )!,
                    nexthop: IPv4(
                        address1octet: 0,
                        address2octet: 0,
                        address3octet: 0,
                        address4octet: 0,
                        subnet1octet: 0,
                        subnet2octet: 0,
                        subnet3octet: 0,
                        subnet4octet: 0,
                        CIDR: 0
                    )!
                )
            ]
        )
    )
}
