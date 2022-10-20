//
//  DailyNoticeView.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/13.
//

import SwiftUI

struct DailyNoticeView: View {
    @Binding var showMenu: Bool
    @Binding var showHistory: Bool
    @Binding var showProfile: Bool
    @State var showSheet = false

    @FetchRequest(entity: Notice.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Notice.noticeTime, ascending: true)])
    var notices: FetchedResults<Notice>

    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    NavigationLink(destination: CalendarView(), isActive: $showHistory) { EmptyView() }
                    NavigationLink(destination: EmptyView(), isActive: $showProfile) { EmptyView() }

                    ScrollView {
                        VStack(spacing: 30) {
                            ForEach(notices) { notice in
                                DailyNoticeCell(notice: notice)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .background(Color(.systemGray5))
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

                        Button {
                            Month.add12MonthEntity()
                        } label: {
                            ColoredImage(source: "12.square")
                            Text("add monthes")
                        }
                    }

                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            withAnimation {
                                showMenu.toggle()
                            }
                        } label: {
                            ColoredImage(source: "list.bullet")
                        }
                    }
                }

                if showMenu {
                    let tap = TapGesture()
                        .onEnded { tap in
                            withAnimation {
                                showMenu.toggle()
                            }
                        }

                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                        .gesture(tap)
                }
            }
        }
    }
}

