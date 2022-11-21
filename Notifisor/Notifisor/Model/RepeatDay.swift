//
//  RepeatDay.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import Foundation

struct RepeatDay {
    let week: Week
    var isSelected: Bool = false
}

enum Week: Int, CaseIterable {
    case sun = 1
    case mon
    case tues
    case wednes
    case thurs
    case fri
    case sat

    var text: String {
        switch self {
        case .sun:
            return "일요일"
        case .mon:
            return "월요일"
        case .tues:
            return "화요일"
        case .wednes:
            return "수요일"
        case .thurs:
            return "목요일"
        case .fri:
            return "금요일"
        case .sat:
            return "토요일"
        }
    }

    var weekDay: String {
        return String(String(describing: self).capitalized.first ?? Character(""))
    }
}
