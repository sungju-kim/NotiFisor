//
//  MenuView.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/14.
//

import SwiftUI

struct MenuView: View {
    @Binding var showHistory: Bool
    @Binding var showProfile: Bool
    @Binding var showMenu: Bool
    let pageDelay = 0.5
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("Notifisor")
                .fixedSize()
                .font(.largeTitle.bold())
                .foregroundColor(Constant.textColor)

            Button {
                withAnimation {
                    showMenu.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + pageDelay) {
                    showHistory.toggle()
                }
            } label: {
                    Image(systemName: "calendar")
                        .imageScale(.large)
                        .foregroundColor(Constant.textColor)
                    Text("전체 기록")
                        .font(.headline)
                        .foregroundColor(Constant.textColor)
            }

            Button {
                withAnimation {
                    showMenu.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + pageDelay) {
                    showProfile.toggle()
                }


            } label: {
                    Image(systemName: "person.crop.circle")
                        .imageScale(.large)
                        .foregroundColor(Constant.textColor)
                    Text("프로필")
                        .font(.headline)
                        .foregroundColor(Constant.textColor)
            }

            Spacer()
        }
        .padding(.horizontal)
        .foregroundColor(.gray)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Constant.pointColor)
    }
}
