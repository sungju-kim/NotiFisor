//
//  CheckerMarkView.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/11/17.
//

import SwiftUI

struct CheckerMark: View {
    @Binding var isDone: Bool

    var body: some View {
        GeometryReader { geo in
            Circle()
                .strokeBorder(isDone ? .white : Color(.systemGray2), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .overlay(alignment: .center) {
                    Image(systemName: "checkmark")
                        .resizable()
                        .foregroundColor(isDone ? .green : Color(.systemGray2))
                        .scaledToFit()
                        .frame(width: geo.size.width / 2)
                }
        }
    }
}

struct CheckerMarkView_Previews: PreviewProvider {
    @State static var isDone: Bool = true
    static var previews: some View {
        CheckerMark(isDone: $isDone)
            .background(.blue)
    }
}
