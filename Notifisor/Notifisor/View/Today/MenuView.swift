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
        VStack(alignment: .leading) {
            Text("Notifisor")
                .fixedSize()
                .font(.largeTitle.bold())
                .foregroundColor(Constant.textColor)
                .padding(.top, 30)

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
                    Text("Record feed")
                        .font(.headline)
                        .foregroundColor(Constant.textColor)
            }
            .padding(.top, 100)

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
                    Text("Profile")
                        .font(.headline)
                        .foregroundColor(Constant.textColor)
            }
            .padding(.top, 30)

            Spacer()
        }
        .padding(.vertical, 20)
        .padding(.horizontal)
        .foregroundColor(.gray)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Constant.pointColor)
        .edgesIgnoringSafeArea(.all)
    }
}
