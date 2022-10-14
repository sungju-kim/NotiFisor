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
        GeometryReader { geometry in
            DailyNoticeView(showMenu: $showMenu)
                .frame(width: geometry.size.width,
                       height: geometry.size.height)
            if self.showMenu {
                MenuView()
                    .frame(width: geometry.size.width/2)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
