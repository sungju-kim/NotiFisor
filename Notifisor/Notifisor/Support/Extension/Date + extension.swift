//
//  Date + extension.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import Foundation

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

    func split() -> [Int] {
        return [self.get(.year), self.get(.month), self.get(.day)]
    }
}
