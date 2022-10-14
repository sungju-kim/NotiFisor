//
//  CalendarView.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import SwiftUI

struct CalendarView: View {
       var body: some View {
           LazyVGrid(columns: Array(repeating: GridItem(), count: 7), alignment: .center, spacing: 16) {
               ForEach(1..<32) { index in
                   DayCell(day: index)
               }
           }
           .padding()
           .background(.ultraThickMaterial)
           .clipShape(RoundedRectangle(cornerRadius: 10))
           .shadow(radius: 1, x: 5, y: 5)

       }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
