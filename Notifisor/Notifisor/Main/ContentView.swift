//
//  ContentView.swift
//  Notifisor
//
//  Created by dale on 2022/10/12.
//

import SwiftUI

struct ContentView: View {

    @State var showMenu = false
    @State var showHistory = false
    @State var showProfile = false

    @FetchRequest(
        entity: Notice.entity(),
        sortDescriptors: []
//            NSSortDescriptor(keyPath: \Notice.title, ascending: true)
//        ],
//        predicate: NSPredicate(format: "genre contains 'Action'")
    ) var notices: FetchedResults<Notice>

    @Environment(\.managedObjectContext) var managedObjectContext
    //    @State var notices: Notices

    var body: some View {
        let drag = DragGesture()
            .onEnded { move in
                withAnimation {
                    showMenu = move.translation.width >= -100
                }
            }

        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                DailyNoticeView(showMenu: $showMenu,
                                showHistory: $showHistory,
                                showProfile: $showProfile,
                                notices: notices
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
            .gesture(drag)
        }
    }
}
