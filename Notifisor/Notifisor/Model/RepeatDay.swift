//
//  RepeatDay.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import Foundation

struct RepeatDay {
    enum WeekDay: String, CaseIterable {
        case everyMonday = "월요일마다"
        case everyTuesday = "화요일마다"
        case everyWednesday = "수요일마다"
        case everyThursday = "목요일마다"
        case everyFriday = "금요일마다"
        case everySaturday = "토요일마다"
        case everySunday = "일요일마다"
    }

    let weekDay: WeekDay
    var isSelected: Bool = false
    var toInt: Int {
        switch self.weekDay {
        case .everyMonday:
            return 2
        case .everyTuesday:
            return 3
        case .everyWednesday:
            return 4
        case .everyThursday:
            return 5
        case .everyFriday:
            return 6
        case .everySaturday:
            return 7
        case .everySunday:
            return 1
        }
    }
}
