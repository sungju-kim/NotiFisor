//
//  Month + extension.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/19.
//
import CoreData
import Foundation

extension Month {
    //MARK: - making entity, saving context
    static func add12MonthEntity() {
        let context = PersistenceController.shared.container.viewContext

        for monthNumber in 1...12 {
            let month = Month(context: context)
            let representDate = Calendar.generateMonthDate(2022, monthNumber)
            let datesOfMonth = Calendar.days(for: representDate)

            let days: [Day] = datesOfMonth.compactMap { dateElement in
                let day = Day(context: context)
                day.date = dateElement
                return day
            }

            month.date = representDate
            month.days = NSSet(array: days)
        }

        do {
            try context.save()
            print("success saving 12 month")
        } catch {
            print("error: fail at saving 12 month")
        }
    }
}
