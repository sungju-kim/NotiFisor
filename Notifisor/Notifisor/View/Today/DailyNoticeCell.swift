//
//  DailyNoticeCell.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import SwiftUI

struct DailyNoticeCell: View {
    @State var notice: Notice
    var body: some View {
        VStack(alignment: .trailing, spacing: 40) {
            HStack {
                Text(notice.title)
                    .font(.title)

                Spacer()

                Text(notice.schedule)
            }
            
            HStack {
                Text(notice.noticeTime, format: .dateTime.hour().minute())
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
            //coreData.save()
        }
    }
}

//struct DailyNoticeCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyNoticeCell()
//    }
//}
