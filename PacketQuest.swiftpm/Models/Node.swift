//
//  File.swift
//  
//
//  Created by Ohara Yoji on 2024/02/25.
//

import Foundation

protocol Node {
    var connected: [Node] { get set }
}
