//
//  TotalListView.swift
//  Notifisor
//
//  Created by dale on 2022/11/17.
//

import RealmSwift
import SwiftUI

struct TotalListView: View {
    //TODO: 추후 변경 가능성
    @ObservedResults(Notice.self) var notices

    var body: some View {
        List {
            ForEach(notices) {
                WholeNoticeCell(notice: $0)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 16)
            }
            .listRowBackground(Constant.background)
            .listRowSeparator(.hidden)
            .listSectionSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
    }
}
