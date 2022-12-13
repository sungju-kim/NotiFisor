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
        VStack {
            HStack {
                Image(systemName: "xmark")
                    .resizable()
                    .foregroundColor(Constant.textColor)
                    .frame(width: 25, height: 25)
                Spacer()
            }
            .padding(.vertical, 64)
            .padding(.horizontal, 32)
            Spacer()
        }
        .background(.black.opacity(0.5))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .onTapGesture {
            withAnimation {
                showMenu.toggle()
            }
        }
    }
}

struct OpaqueBlackView_Previews: PreviewProvider {
    @State static private var showMenu = false

    static var previews: some View {
        OpaqueBlackView(showMenu: $showMenu)
    }
}
