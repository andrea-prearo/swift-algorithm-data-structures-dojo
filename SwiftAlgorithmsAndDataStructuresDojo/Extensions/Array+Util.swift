//
//  Array+Util.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Prearo, Andrea on 5/19/17.
//
//

import Foundation

public extension Array {
    mutating func shuffle() {
        for _ in 0..<count {
            sort { (_, _) in arc4random() < arc4random() }
        }
    }
}
