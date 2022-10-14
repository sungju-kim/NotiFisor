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
            DailyNoticeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
