//
//  MonthView.swift
//  Notifisor
//
//  Created by dale on 2022/10/21.
//

import SwiftUI

struct MonthView: View {
    @Environment(\.calendar) var calendar
    @Binding var date: Date

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7), alignment: .center, spacing: 16) {
            WeekDayView()
            ForEach(calendar.days(for: date), id: \.self) { day in
                let cell = DayCell(date: day)

                if calendar.isDate(day, equalTo: date, toGranularity: .month) {
                    cell
                } else {
                    cell.hidden()
                }
            }
        }
        .padding()
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 1, x: 5, y: 5)
    }
}

