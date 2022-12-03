//
//  CalendarView.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//
import SwiftUI

struct CalendarView: View {
    @Environment(\.calendar) var calendar: Calendar
    @State var date: Date = .now
    @State var year: Int = Date.now.get(.year)
    @State var month: Int = Date.now.get(.month)
    @State var isShowing: Bool = false

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
                FlexibleView(data: currentNotice)
            }
            .padding(.horizontal)
        }
        .background(Constant.background)
    }
}
