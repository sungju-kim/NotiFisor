//
//  DailyNoticeCell.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import RealmSwift
import SwiftUI

struct DailyNoticeCell: View {
    @ObservedRealmObject var notice: Notice
    @State private var isShowEditSheet = false

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(notice.title)
                        .font(.title2)
                        .lineLimit(2)
                        .layoutPriority(1)

                    Spacer()

                    EllipsisView(notice: notice, isShowEditSheet: $isShowEditSheet)
                        .frame(width: 30, height: 30)
                }

                HStack {
                    Text(notice.amount ?? 0, format: .number)
                    Text(notice.unit.text)

                    Spacer()

                    Text(notice.noticeTime, format: .dateTime.hour().minute())
                    Text("알림 예정")
                }
                .foregroundStyle(.secondary)
                .padding(.top, 4)
            }
        }
        .padding()
        .background(.ultraThickMaterial)
        .background(notice.isDone ? .yellow : Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 1, x: 5, y: 5)
        .sheet(isPresented: $isShowEditSheet) {
            NoticeEditView(notice)
        }
    }

}

