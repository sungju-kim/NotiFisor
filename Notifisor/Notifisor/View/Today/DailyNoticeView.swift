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
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: EmptyView(), isActive: $showHistory) { EmptyView() }
                NavigationLink(destination: EmptyView(), isActive: $showProfile) { EmptyView() }

                ScrollView {
                    VStack(spacing: 30) {
                        ForEach(0..<10) { _ in
                            DailyNoticeCell()
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
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
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
                        Image(systemName: "list.bullet")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

