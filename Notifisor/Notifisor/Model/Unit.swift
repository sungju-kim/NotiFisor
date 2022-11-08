//
//  Unit.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import Foundation

@objc
public enum Unit: Int16 {

    case hour = 0
    case minute = 1
    case km = 2
    case times = 3

}

extension Unit: CaseIterable {
    var text: String {
        switch self {
        case .hour:
            return "시간"
        case .minute:
            return "분"
        case .km:
            return "km"
        case .times:
            return "회"
        }
    }
}
