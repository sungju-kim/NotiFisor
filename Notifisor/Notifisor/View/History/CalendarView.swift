//
//  CalendarView.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import SwiftUI

struct CalendarView: View {
    let columns: [GridItem] = (0..<7).map { _ in GridItem(.flexible(minimum: 0, maximum: 1000), spacing: nil, alignment: nil) }

       var body: some View {
           LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
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
