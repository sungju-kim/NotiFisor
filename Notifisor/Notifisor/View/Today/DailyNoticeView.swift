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
    let notices: Notices
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    NavigationLink(destination: CalendarView(), isActive: $showHistory) { EmptyView() }
                    NavigationLink(destination: EmptyView(), isActive: $showProfile) { EmptyView() }

                    ScrollView {
                        VStack(spacing: 30) {
                            ForEach(notices, id: \.self) { notice in
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

