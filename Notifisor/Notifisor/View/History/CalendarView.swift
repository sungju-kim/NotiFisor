//
//  CalendarView.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//
import SwiftUI

struct CalendarView: View {
    @Environment(\.calendar) var calendar

    @State var month: Date = .now

    private var beforeMonth: Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: month) ?? Date()
    }

    private var nextMonth: Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: month) ?? Date()
    }

    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), alignment: .center, spacing: 16) {
                Section {
                    DayOfWeekView()
                    ForEach(days(for: month), id: \.self) { date in
                        let cell = DayCell(day: date.get(.day))
                        if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                            cell
                        } else {
                            cell.hidden()
                        }
                    }
                } header: {
                    HStack {
                        Button {
                            month = beforeMonth
                        } label: {
                            Image(systemName: "chevron.left")
                        }

                        Text(DateFormatter.monthAndYear.string(from: month))
                            .font(.title)

                        Button {
                            month = nextMonth
                        } label: {
                            Image(systemName: "chevron.right")
                        }

                    }
                }
            }
            .padding()
            .background(.ultraThickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 1, x: 5, y: 5)
        }

    }

    private func days(for month: Date) -> [Date] {
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

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
