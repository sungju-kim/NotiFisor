//
//  DailyNoticeCell.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import RealmSwift
import SwiftUI

struct DailyNoticeCell: View {
    @ObservedRealmObject var notice: CurrentNotice
    @EnvironmentObject var noticeRepository: NoticeRepository

    @State private var isShowEditSheet = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(notice.title)
                    .font(.title2)
                    .lineLimit(2)
                    .layoutPriority(1)

                Spacer()

                Button {
                    noticeRepository.write {
                        notice.thaw()?.isDone.toggle()
                    }
                } label: {
                    if notice.isDone {
                        Circle()
                            .fill(Constant.pointColor)
                    } else {
                        Circle()
                            .strokeBorder(Color(.gray), lineWidth: 3)
                    }
                }
                .frame(width: 20, height: 20)
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
        .shadowCellStyle()
        .sheet(isPresented: $isShowEditSheet) {
            NoticeEditView(notice)
        }
    }

}

