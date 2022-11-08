//
//  DailyNoticeCell.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import SwiftUI

struct DailyNoticeCell: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var notice: Notice
    @State private var isShowEdieSheet = false

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(notice.title ?? "")
                    .font(.title)

                HStack {
                    Text(notice.noticeTime ?? Date.now , format: .dateTime.hour().minute())
                        .foregroundStyle(.secondary)

                    Text("알림 예정")
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 8)
            }

            Spacer()

            Menu {
                Button("완료", action: finishJob)
                Button("수정", action: editNotice)
                Button("삭제", role: .destructive, action: deleteNotice)
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
        .sheet(isPresented: $isShowEdieSheet) {
            NoticeEditView(notice)
        }
        
    }

    private func finishJob() {
        notice.isDone.toggle()
        saveContext()
    }

    private func editNotice() {
        isShowEdieSheet = true
    }

    private func deleteNotice() {
        managedObjectContext.delete(notice)
        saveContext()
    }

    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Saving context got errored --> \(#file)")
        }
    }
}

struct DailyNoticeCell_Previews: PreviewProvider {
    @FetchRequest(entity: Notice.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Notice.noticeTime, ascending: true)])
    static var notices: FetchedResults<Notice>

    static var previews: some View {
        DailyNoticeCell(notice: notices[0])
    }
}
