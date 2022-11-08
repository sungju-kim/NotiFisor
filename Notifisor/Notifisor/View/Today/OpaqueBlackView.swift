//
//  OpaqueBlackView.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/11/09.
//

import SwiftUI

struct OpaqueBlackView: View {
    @Binding var showMenu: Bool

    var body: some View {
        let tap = TapGesture()
            .onEnded { tap in
                withAnimation {
                    showMenu.toggle()
                }
            }

        return Color.black.opacity(0.5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .gesture(tap)
    }
}

struct OpaqueBlackView_Previews: PreviewProvider {
    @State static private var showMenu = false

    static var previews: some View {
        OpaqueBlackView(showMenu: $showMenu)
    }
}
