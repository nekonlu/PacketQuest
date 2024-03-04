//
//  File.swift
//  
//
//  Created by Ohara Yoji on 2024/02/25.
//

import Foundation

struct IPv4: Identifiable {
    let id: UUID = .init()
    let address1octet: Int
    let address2octet: Int
    let address3octet: Int
    let address4octet: Int
    let subnet1octet: Int
    let subnet2octet: Int
    let subnet3octet: Int
    let subnet4octet: Int
    let CIDR: Int

    init?(
        address1octet: Int,
        address2octet: Int,
        address3octet: Int,
        address4octet: Int,
        subnet1octet: Int,
        subnet2octet: Int,
        subnet3octet: Int,
        subnet4octet: Int,
        CIDR: Int
    ) {
        if      (0 <= address1octet && address1octet <= 255) &&
                (0 <= address2octet && address2octet <= 255) &&
                (0 <= address3octet && address3octet <= 255) &&
                (0 <= address4octet && address4octet <= 255) &&
                (0 <= subnet1octet && subnet1octet <= 255) &&
                (0 <= subnet2octet && subnet2octet <= 255) &&
                (0 <= subnet3octet && subnet3octet <= 255) &&
                (0 <= subnet4octet && subnet4octet <= 255) &&
                (0 <= CIDR && CIDR <= 32)
        {
            self.address1octet = address1octet
            self.address2octet = address2octet
            self.address3octet = address3octet
            self.address4octet = address4octet
            self.subnet1octet = subnet1octet
            self.subnet2octet = subnet2octet
            self.subnet3octet = subnet3octet
            self.subnet4octet = subnet4octet
            self.CIDR = CIDR
        } else {
            print("\(#function) ERROR!!!!!!!")
            return nil
        }
    }

    func displayIP() -> String {
        return "\(address1octet).\(address2octet).\(address3octet).\(address4octet)/\(CIDR)"
    }

    static func splitCIDRAddress(_ cidrAddress: String) -> IPv4? {
        let components = cidrAddress.components(separatedBy: "/")
        guard components.count == 2,
              let ipAddress = components.first,
              let subnetMaskString = components.last,
              let subnetMask = Int(subnetMaskString) else {
            return nil
        }

        guard subnetMask >= 0 && subnetMask <= 32 else {
            return nil
        }

        var subm = subnetMask

        var maskComponents = [Int](repeating: 0, count: 4)
        for i in 0..<4 {
            if subm >= 8 {
                maskComponents[i] = 255
                subm -= 8
            } else {
                maskComponents[i] = Int(pow(2.0, Double(8 - subm))) - 1
                subm = 0
            }
        }

        let ipComponents = ipAddress.components(separatedBy: ".")
        guard ipComponents.count == 4,
              let octet1 = Int(ipComponents[0]),
              let octet2 = Int(ipComponents[1]),
              let octet3 = Int(ipComponents[2]),
              let octet4 = Int(ipComponents[3]) else {
            return nil
        }

        if let ip = IPv4(
            address1octet: octet1,
            address2octet: octet2,
            address3octet: octet3,
            address4octet: octet4,
            subnet1octet: maskComponents[0],
            subnet2octet: maskComponents[1],
            subnet3octet: maskComponents[2],
            subnet4octet: maskComponents[3],
            CIDR: subnetMask
        ) {
            return ip
        } else {
            return nil
        }
    }
}
