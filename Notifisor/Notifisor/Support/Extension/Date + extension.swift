//
//  Date + extension.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import Foundation

extension Date {
    var kst: Date {
        return self.addingTimeInterval(32400)
    }

    static var kst: Date {
        return Date.now.addingTimeInterval(32400)
    }

    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

    func split() -> [Int] {
        return [self.get(.year), self.get(.month), self.get(.day)]
    }

    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self))) ?? Date.kst
    }

    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth()) ?? Date.kst
    }

    var id: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
