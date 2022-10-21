//
//  NumbersOnly.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import Foundation

struct NumbersOnly {
    var value: String = "1" {
        didSet {
            let filterdValue = value.filter { $0.isNumber }
            value = filterdValue
        }
    }
}
