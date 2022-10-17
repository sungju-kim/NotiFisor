//
//  DayOfWeekView.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/17.
//

import SwiftUI

struct DayOfWeekView: View {

    enum DayOfTheWeek: CaseIterable {
        case sunday
        case monday
        case tuseday
        case wednesday
        case thursday
        case friday
        case saturday

        var dayOfTheWeek: String {
            guard let firstChracter =  String(describing: self).capitalized.first else { return "" }
            return String(firstChracter)
        }
    }

    var body: some View {
        ForEach(DayOfTheWeek.allCases, id: \.self) {
            Text($0.dayOfTheWeek)
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
