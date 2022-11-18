//
//  DayCell.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import RealmSwift
import SwiftUI

struct DayCell: View {
    @EnvironmentObject private var repository: NoticeRepository

    let date: Date

    private var day: Day {
        return repository.get(Day.self, date.id) as? Day ?? Day(value: ["date": date])
    }

    private var percentage: Double {
        return day.achievementRate
    }

    var body: some View {
        NavigationLink {
            HistoryNoticeView(day: day)
        } label: {
            ZStack {
                Text(date.get(.day), format: .number)
                    .font(.callout)
                    .foregroundColor(.primary)
                
                Circle()
                    .stroke(Color.gray, lineWidth: 5)
                    .opacity(0.1)

                Circle()
                    .trim(from: 0, to: percentage)
                    .stroke(style: StrokeStyle(lineWidth: 5,
                                               lineCap: .round,
                                               lineJoin: .round))
                    .foregroundColor(.yellow)
                    .rotationEffect(.degrees(-90))
            }
        }
    }
}
