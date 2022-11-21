//
//  WholeNoticeCell.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/11/21.
//

import RealmSwift
import SwiftUI

struct WholeNoticeCell: View {
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
                    
                    EllipsisView(notice: notice, isShowEditSheet: $isShowEditSheet, canShowFinish: false)
                        .frame(width: 30, height: 30)
                }
                
                HStack {
                    WeekDayView(selectedDay: Array(notice.repeats))
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                        
                }
                .foregroundStyle(.secondary)
                .padding(.top, 4)
            }
        }
        .padding()
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 1, x: 5, y: 5)
        .sheet(isPresented: $isShowEditSheet) {
            NoticeEditView(notice)
        }
    }
}

struct WholeNoticeCell_Previews: PreviewProvider {
    @ObservedResults(Notice.self) static var notices
    static var previews: some View {
        WholeNoticeCell(notice: notices.first!)
    }
}
