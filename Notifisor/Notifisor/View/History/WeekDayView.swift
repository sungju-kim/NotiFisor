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
            Text(weekday.weekDay)
                .foregroundColor(selectedDay.contains(weekday.rawValue) ? Constant.pointColor : .gray)
        }
    }
}
