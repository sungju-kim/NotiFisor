//
//  HistoryNoticeView.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import RealmSwift
import SwiftUI

struct HistoryNoticeView: View {
    @ObservedRealmObject var day: Day
    private var text: String {
        let date = day.date.split()
        return "\(date[0])년 \(date[1])월 \(date[2])일"
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(day.notices) {
                    HistoryNoticeCell(notice: $0)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .background(Constant.background)
        .navigationTitle(text)
    }
}
