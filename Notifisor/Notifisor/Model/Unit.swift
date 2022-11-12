//
//  Unit.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import Foundation
import RealmSwift

enum Unit: String, PersistableEnum {
    case hour
    case minute
    case km
    case times

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
