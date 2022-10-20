//
//  CalendarView.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//
import SwiftUI

struct CalendarView: View {
    @Environment(\.calendar) var calendar

    @FetchRequest (
        entity: Month.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "date == %@", argumentArray: [Calendar.generateMonthDate(Date.now)])
    ) var month: FetchedResults<Month>

    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), alignment: .center, spacing: 16) {
                Section {
                    DayOfWeekView()
                    if let days = month.first?.days?.allObjects as? [Day],
                       let representDate = month.first?.date
                    {
                        ForEach(days.sorted(), id: \.self) { day in
                            let cell = DayCell(day: day.date?.get(.day) ?? 0)
                            if calendar.isDate(day.date ?? Date(), equalTo: representDate, toGranularity: .month) {
                                cell
                            } else {
                                cell.hidden()
                            }
                        }
                    }
                } header: {
                    HStack {
                        Button {
                            fetchMonth(isNextTo: false)
                        } label: {
                            Image(systemName: "chevron.left")
                        }

                        Text(DateFormatter.monthAndYear.string(from: month.first?.date ?? Date()))
                            .font(.title)

                        Button {
                            fetchMonth(isNextTo: true)
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

    private func fetchMonth(isNextTo: Bool) {
        let move = isNextTo ? 1 : -1
        let currentDate = month.first?.date ?? Date()
        let movedDate = Calendar.current
            .date(byAdding: .month, value: move, to: currentDate) ?? Date()
        month.nsPredicate = NSPredicate(format: "date == %@", argumentArray: [movedDate])
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
