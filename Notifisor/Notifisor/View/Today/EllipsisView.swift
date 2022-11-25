//
//  EllipsisView.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/11/17.
//
import RealmSwift
import SwiftUI

struct EllipsisView: View {
    @EnvironmentObject var noticeRepository: NoticeRepository
    @ObservedRealmObject var notice: NoticeType
    @Binding var isShowEditSheet: Bool
    let canShowFinish: Bool
    
    init(notice: NoticeType, isShowEditSheet: Binding<Bool> = .constant(false), canShowFinish: Bool = true) {
        self.notice = notice
        self.canShowFinish = canShowFinish
        self._isShowEditSheet = isShowEditSheet
    }
    
    var body: some View {
        Menu {
            Group {
                Button("수정", action: {
                    isShowEditSheet.toggle()
                })
                if let notice = notice as? CurrentNotice {
                    Button("완료", action: {
                        noticeRepository.write {
                            notice.thaw()?.isDone.toggle()
                        }
                    })
                }
            }
        } label: {
            GeometryReader { geo in
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90), anchor: .top)
                    .foregroundColor(.secondary)
                    .frame(width: geo.size.width * 0.8)
                    .frame(width: geo.size.width, height: geo.size.height)
            }

        }
    }
}
