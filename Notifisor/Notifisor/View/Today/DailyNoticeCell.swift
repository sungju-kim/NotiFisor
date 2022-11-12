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
                Text(notice.title)
                    .font(.title)

                HStack {
                    Text(notice.noticeTime, format: .dateTime.hour().minute())
                        .foregroundStyle(.secondary)

                    Text("알림 예정")
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 8)
            }

            Spacer()

            Menu {
                Button("완료", action: {})
                Button("수정", action: {
                    isShowEditSheet.toggle()
                })
                Button("삭제", role: .destructive, action: {})
            } label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90), anchor: .top)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .background(notice.isDone ? .yellow : Color(.systemGray5))
        .shadow(radius: 1, x: 5, y: 5)
        .sheet(isPresented: $isShowEditSheet) {
            NoticeEditView(notice)
        }
        
    }

}

