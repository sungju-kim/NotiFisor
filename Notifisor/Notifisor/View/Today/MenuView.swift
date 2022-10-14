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

    var body: some View {
        VStack(alignment: .leading) {
            Text("Notifisor")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                .padding(.top, 30)

            Button {
                withAnimation {
                    showHistory.toggle()
                    showMenu.toggle()
                }
            } label: {
                    Image(systemName: "calendar")
                        .imageScale(.large)
                    Text("Record feed")
                        .font(.headline)
            }
            .padding(.top, 100)

            Button {
                withAnimation {
                    showProfile.toggle()
                    showMenu.toggle()
                }
            } label: {
                    Image(systemName: "person.crop.circle")
                        .imageScale(.large)
                    Text("Profile")
                        .font(.headline)
            }
            .padding(.top, 30)

            Spacer()
        }
        .padding()
        .foregroundColor(.gray)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
    }
}
