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
}
