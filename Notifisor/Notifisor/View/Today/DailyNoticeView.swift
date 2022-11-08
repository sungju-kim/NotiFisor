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

    @FetchRequest(
        entity: Notice.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Notice.noticeTime, ascending: true)]
    )
    var notices: FetchedResults<Notice> {
        didSet {
            try! managedObjectContext.save()
        }
    }

    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    ForEach(notices) { notice in
                        DailyNoticeCell(notice: notice)
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
            .overlay {
                if showMenu {
                    OpaqueBlackView(showMenu: $showMenu)
                }
            }
            .background(Color(.systemGray5))
            .overlay {
                NavigationLink(destination: CalendarView(), isActive: $showHistory) { EmptyView() }
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
                    }
                }
            }
        }
    }
}


struct DailyNoticeView_Previews: PreviewProvider {
    @State static var showMenu = false
    @State static var showHistory = false
    @State static var showProfile = false
    
    static var previews: some View {
        DailyNoticeView(showMenu: $showMenu, showHistory: $showHistory, showProfile: $showProfile)
    }
}
