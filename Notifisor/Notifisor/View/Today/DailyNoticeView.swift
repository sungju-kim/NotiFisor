//
//  DailyNoticeView.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/13.
//

import RealmSwift
import SwiftUI

struct DailyNoticeView: View {
    @Binding var showMenu: Bool
    @Binding var showHistory: Bool
    @Binding var showProfile: Bool
    @State var showSheet = false

    @StateRealmObject var day: Day

    var body: some View {
        NavigationView {
            TabView {
                ScrollView{
                    VStack(spacing: 30) {
                        ForEach(day.notices) {
                            DailyNoticeCell(notice: $0)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 16)
                }
                .navigationTitle("오늘 일정")
                TotalListView()
                    .navigationTitle("전체 등록 일정")
            }
            .tabViewStyle(PageTabViewStyle())

            .frame(maxWidth: .infinity)
            .background(Constant.background)
            .overlay {
                NavigationLink(destination: CalendarView(), isActive: $showHistory) { EmptyView() }
                    .navigationTitle("달성률 조회")
                    .navigationBarTitleDisplayMode(.inline)
                NavigationLink(destination: EmptyView(), isActive: $showProfile) { EmptyView() }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showSheet.toggle()
                    } label: {
                        ColoredImage(source: "plus")
                    }
                    .sheet(isPresented: $showSheet) {
                        NoticeEditView()
                    }
                }

                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            showMenu.toggle()
                        }
                    } label: {
                        ColoredImage(source: "list.bullet")
                            .opacity(showMenu ? 0 : 1)
                    }
                }
            }
        }
    }
}
