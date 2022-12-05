//
//  CalendarView.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//
import SwiftUI
import RealmSwift

struct CalendarView: View {
    @Environment(\.calendar) var calendar: Calendar
    @State var date: Date = .kst
    @State var year: Int = Date.kst.get(.year)
    @State var month: Int = Date.kst.get(.month)
    @State var isShowing: Bool = false

    @ObservedResults(Day.self) var days

    var body: some View {
        let currentNotice = CurrentNotice()
        currentNotice.title = "달리기"
        currentNotice.repeats.append(objectsIn: [1,3,5])
        currentNotice.unit = .km
        currentNotice.amount = 3
        
        return ScrollView {
            VStack {
                CustomPicker(date: $date, year: $year, month: $month, isShowing: $isShowing)
                MonthView(date: $date)
                if let filtered = days.filter("date BETWEEN {%@, %@}", date.startOfMonth(), date.endOfMonth()),
                   let notices = filtered.reduce(into: [CurrentNotice]()) { $0 += $1.notices.filter { $0.isDone } },
                   let targets = getMost(notices: notices) {
                       FlexibleView(data: targets)
                }
            }
            .padding(.horizontal)
        }
        .background(Constant.background)
    }

    private func getMost(notices: [CurrentNotice]) -> [CurrentNotice: Double] {
        var counter: [CurrentNotice: Double] = [:]
        notices.forEach { counter[$0, default: 0] += $0.amount ?? 0}
        let max = counter.values.max()

        return counter.filter { $0.value == max }
    }
}
