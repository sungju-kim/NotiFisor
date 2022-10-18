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
    var body: some View {
        VStack(alignment: .trailing, spacing: 40) {
            HStack {
                Text(notice.title ?? "")
                    .font(.title)

                Spacer()

                Text("\(notice.amount)\(notice.unit ?? "")")
            }

            HStack {
                Text(notice.noticeTime ?? Date.now , format: .dateTime.hour().minute())
                    .foregroundStyle(.secondary)

                Text("알림 예정")
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .background(notice.isDone ? .yellow : Color(.systemGray5))
        .shadow(radius: 1, x: 5, y: 5)
        .onTapGesture {
            notice.isDone.toggle()
            saveContext()
        }
    }

    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("error")
        }
    }
}

