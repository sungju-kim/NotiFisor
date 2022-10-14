//
//  ContentView.swift
//  Notifisor
//
//  Created by dale on 2022/10/12.
//

import SwiftUI

struct ContentView: View {

    @State var showMenu = false

    var body: some View {
        let drag = DragGesture()
            .onEnded { move in
                withAnimation {
                    showMenu = move.translation.width >= -100
                }
            }

        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                DailyNoticeView(showMenu: $showMenu)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: showMenu ? geometry.size.width/2 : 0)
                    .disabled(showMenu)
                if showMenu {
                    MenuView()
                        .frame(width: geometry.size.width/2)
                        .transition(.move(edge: .leading))
                }
            }
            .gesture(drag)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
