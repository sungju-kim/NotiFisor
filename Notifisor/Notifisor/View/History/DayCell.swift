//
//  DayCell.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import SwiftUI

struct DayCell: View {
    let day: Int
    var body: some View {
        NavigationLink {

        } label: {
            VStack {
                Text(day, format: .number)
                    .font(.title)
                    .foregroundColor(.black)

                FulfillmentView(startAngle: 0, endAngle: 270)
                    .fill(Color.yellow)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 30, height: 30)
            }
        }
    }
}

struct DayCell_Previews: PreviewProvider {
    static var previews: some View {
        DayCell(day: 1)
    }
}
