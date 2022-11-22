//
//  WeekDayView.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/17.
//

import SwiftUI

struct WeekDayView: View {
    
    let selectedDay: [Int]
    
    init(selectedDay: [Int] = []) {
        self.selectedDay = selectedDay
    }
    
    var body: some View {
        ForEach(Week.allCases, id: \.self) { weekday in
            ZStack {
                if selectedDay.contains(weekday.rawValue) {
                    Circle()
                        .stroke(.yellow,
                                style: StrokeStyle(lineWidth: 2,
                                                   lineCap: .round,
                                                   lineJoin: .round))
                        .frame(width: 20)
                }
                
                Text(weekday.weekDay)
            }
        }
    }
}
