//
//  DayCell.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import SwiftUI

struct DayCell: View {
    let date: Date
    var percentage: CGFloat = 0

    var body: some View {
        NavigationLink {

        } label: {
            ZStack {
                Text(date.get(.day), format: .number)
                    .font(.callout)
                    .foregroundColor(.black)
                
                Circle()
                    .stroke(Color.gray, lineWidth: 5)
                    .opacity(0.1)

                Circle()
                    .trim(from: 0, to: percentage)
                    .stroke(style: StrokeStyle(lineWidth: 5,
                                               lineCap: .round,
                                               lineJoin: .round))
                    .foregroundColor(.yellow)
                    .rotationEffect(.degrees(-90))
            }
        }
    }
}

struct DayCell_Previews: PreviewProvider {
    static var previews: some View {
        DayCell(date: .now, percentage: 0.8)
    }
}
