//
//  TotalListView.swift
//  Notifisor
//
//  Created by dale on 2022/11/17.
//

import RealmSwift
import SwiftUI

struct TotalListView: View {

    @ObservedResults(Weekday.self) var weekdays

    var body: some View {
        List {
            ForEach(weekdays) { week in
                Section {
                    ForEach(week.notices) {
                        DailyNoticeCell(notice: $0)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 16)
                    }
                } header: {
                    Text("\((Week(rawValue: week.id) ?? .mon).text)")
                        .font(.headline)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .background(Color(.systemGray5))
                }
                .listRowBackground(Color(.systemGray5))
                .listRowSeparator(.hidden)
                .listSectionSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

            }
        }
        .listStyle(.plain)
    }
}
