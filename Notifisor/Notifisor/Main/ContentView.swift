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
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }

        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                DailyNoticeView(showMenu: $showMenu)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                    .disabled(self.showMenu ? true : false)
                if self.showMenu {
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
