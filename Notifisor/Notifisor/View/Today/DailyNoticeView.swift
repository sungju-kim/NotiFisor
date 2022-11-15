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

    @EnvironmentObject private var repository: NoticeRepository

    @ObservedResults(Day.self, filter: NSPredicate(format: "_id == %@", Date.now.id)) var days

    private var day: Day {
        return days.first ?? Day()
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    ForEach(day.notices) {
                        DailyNoticeCell(notice: $0)
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
                            .onDisappear {
                                fetchDay()
                            }
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
        .onAppear {
            fetchDay()
        }
    }

    func fetchDay() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let id = formatter.string(from: Date.now)
        guard let weekday = repository.get(Weekday.self, Date.now.get(.weekday)) as? Weekday else { return }
        repository.updateInfo(Day.self, ObjectId(), ["_id": id, "date": Date.now, "notices": weekday.notices])
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
