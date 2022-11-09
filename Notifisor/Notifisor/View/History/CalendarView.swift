//
//  CalendarView.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//
import SwiftUI

struct CalendarView: View {
    var body: some View {
        VStack {
            MonthView()
                .padding()
            Spacer()
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
