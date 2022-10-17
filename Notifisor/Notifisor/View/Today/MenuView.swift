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
        let drag = DragGesture()
            .onEnded { move in
                withAnimation {
                    showMenu = move.translation.width >= -100
                }
            }

        VStack(alignment: .leading) {
            Text("Notifisor")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                .padding(.top, 30)

            Button {
                showMenu.toggle()
                withAnimation {
                    showHistory.toggle()
                }
            } label: {
                    Image(systemName: "calendar")
                        .imageScale(.large)
                    Text("Record feed")
                        .font(.headline)
            }
            .padding(.top, 100)

            Button {
                showMenu.toggle()
                withAnimation {
                    showProfile.toggle()
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
        .gesture(drag)
    }
}
