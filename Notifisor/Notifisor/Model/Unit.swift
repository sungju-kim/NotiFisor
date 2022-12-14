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
            return "μκ°"
        case .minute:
            return "λΆ"
        case .km:
            return "km"
        case .times:
            return "ν"
        }
    }
}
