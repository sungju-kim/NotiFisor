//
//  MonthView.swift
//  Notifisor
//
//  Created by dale on 2022/10/21.
//

import SwiftUI

struct MonthView: View {
    @Environment(\.calendar) var calendar
    @State var month: Date = .now
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7), alignment: .center, spacing: 16) {
            Section {
                WeekDayView()
                ForEach(calendar.days(for: month), id: \.self) { day in
                    let cell = DayCell(date: day)

                    if calendar.isDate(day, equalTo: month, toGranularity: .month) {
                        cell
                    } else {
                        cell.hidden()
                    }
                }
            } header: {
                HStack {
                    Button {
                        month = calendar.date(byAdding: .month, value: -1, to: month) ?? Date()
                    } label: {
                        Image(systemName: "chevron.left")
                    }


                    Text(DateFormatter.monthAndYear.string(from: month))
                        .font(.title)

                    Button {
                        month = calendar.date(byAdding: .month, value: 1, to: month) ?? Date()
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                    .disabled(isCurrentMonth())

                }
            }
        }
        .padding()
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 1, x: 5, y: 5)
    }

    private func isCurrentMonth() -> Bool {
        return calendar.dateComponents([.year, .month], from: month) == calendar.dateComponents([.year, .month], from: .now)
    }
}

