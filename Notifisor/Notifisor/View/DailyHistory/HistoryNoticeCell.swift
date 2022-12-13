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

    var isResolved: Bool {
        return notice.isDone
    }

    var body: some View {
        HStack {
            Text("\(title)")
                .font(.title)
                .foregroundColor(isResolved ? Constant.textColor : Constant.reverseTextColor)

            Spacer()
        }
        .padding()
        .background(isResolved ? Constant.pointColor : Constant.background)
        .shadowCellStyle()
    }
}
