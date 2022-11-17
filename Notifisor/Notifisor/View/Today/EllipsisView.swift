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
    @ObservedRealmObject var notice: Notice
    @Binding var isShowEditSheet: Bool
    
    var body: some View {
        Menu {
            Button("완료", action: {
                do {
                    try noticeRepository.realm.write {
                        notice.thaw()?.isDone.toggle()
                    }
                } catch(let error) {
                    print(error.localizedDescription)
                }
            })
            Button("수정", action: {
                isShowEditSheet.toggle()
            })
        } label: {
            Image(systemName: "ellipsis")
                .rotationEffect(.degrees(90), anchor: .top)
                .frame(width: 40, height: 40)
                .foregroundColor(.secondary)
        }
    }
}
