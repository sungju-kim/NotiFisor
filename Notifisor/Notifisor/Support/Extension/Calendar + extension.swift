//
//  Calendar + extension.swift
//  Notifisor
//
//  Created by dale on 2022/10/14.
//

import Foundation

extension Calendar {
    func generateDates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates: [Date] = [interval.start]

        enumerateDates(startingAfter: interval.start,
                       matching: components,
                       matchingPolicy: .nextTime) { date, _, stop in

            guard let date = date else { return }

            let isValid = date < interval.end

            if isValid { dates.append(date) }

            stop = !isValid
        }
        return dates
    }

    static func generateMonthDate(_ date: Date) -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        return Calendar.current.date(from: components) ?? Date.now
    }

    func generateMonthDate(_ year: Int, _ month: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        return Calendar.current.date(from: components) ?? Date()
    }

    func days(for month: Date) -> [Date] {
        let calendar = Self.current
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month),
            let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }

        return calendar.generateDates(
            inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
}
