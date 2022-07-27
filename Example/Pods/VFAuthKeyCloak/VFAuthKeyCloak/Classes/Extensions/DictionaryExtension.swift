//
//  Dictionary.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 10/23/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

import Foundation
extension Dictionary {
    public static func +=(lhs: inout [Key: Value], rhs: [Key: Value]) { rhs.forEach({ lhs[$0] = $1}) }
    
    mutating func merge(dict: [Key: Value]) {
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
