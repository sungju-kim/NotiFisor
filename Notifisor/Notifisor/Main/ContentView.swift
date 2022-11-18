//
//  ContentView.swift
//  Notifisor
//
//  Created by dale on 2022/10/12.
//

import RealmSwift
import SwiftUI

struct ContentView: View {

    @State var showMenu = false
    @State var showHistory = false
    @State var showProfile = false

    @EnvironmentObject var repository: NoticeRepository

    private var day: Day {
        return repository.get(Day.self, Date.now.id) as? Day ?? Day()
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                DailyNoticeView(showMenu: $showMenu,
                                showHistory: $showHistory,
                                showProfile: $showProfile,
                                day: day
                )
                .frame(width: geometry.size.width, height: geometry.size.height)
                .offset(x: showMenu ? geometry.size.width/2 : 0)
                if showMenu {
                    MenuView(showHistory: $showHistory,
                             showProfile: $showProfile,
                             showMenu: $showMenu
                    )
                    .frame(width: geometry.size.width/2)
                    .transition(.move(edge: .leading))
                }
            }
        }
    }
}
