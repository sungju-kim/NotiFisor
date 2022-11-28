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
        ScrollView {
            VStack {
                CustomPicker(date: $date, year: $year, month: $month, isShowing: $isShowing)
                MonthView(date: $date)
                    .padding(.horizontal)
            }
        }
        .background(Constant.background)
    }
}
