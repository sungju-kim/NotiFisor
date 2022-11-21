//
//  WeekDayView.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/17.
//

import SwiftUI

struct WeekDayView: View {
    var body: some View {
        ForEach(Week.allCases, id: \.self) {
            Text($0.weekDay)
                .font(.title3.bold())
        }
    }
}
