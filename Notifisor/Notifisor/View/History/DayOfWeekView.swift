//
//  DayOfWeekView.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/17.
//

import SwiftUI

struct DayOfWeekView: View {
    var body: some View {
        ForEach(Week.allCases, id: \.self) {
            Text($0.weekDay)
                .font(.title3.bold())
        }
    }
}

struct DayOfWeekView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            DayOfWeekView()
        }
    }
}
