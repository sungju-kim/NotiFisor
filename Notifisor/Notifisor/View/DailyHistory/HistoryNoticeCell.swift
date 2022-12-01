//
//  HistoryNoticeCell.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import RealmSwift
import SwiftUI

struct HistoryNoticeCell: View {
    @ObservedRealmObject var notice: CurrentNotice
    var title: String {
        return notice.title
    }

    //TODO: - 완료시각으로 변경 필요
    var resolvedTime: String {
        let hour = notice.noticeTime.get(.hour)
        let minute = notice.noticeTime.get(.minute)
        return "\(hour) : \(minute)"
    }

    var isResolved: Bool {
        return notice.isDone
    }

    var body: some View {
        HStack {
            Text("\(title)")
                .font(.title)

            Spacer()

            Text("\(resolvedTime)")
                .font(.title)
                .foregroundColor(isResolved ? .blue : .gray)
        }
        .background(isResolved ? Constant.pointColor : .white)
        .shadowCellStyle()
    }
}

