//
//  DailyNoticeCell.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import SwiftUI

struct DailyNoticeCell: View {
    var body: some View {
        VStack(alignment: .trailing, spacing: 40) {
            HStack {
                Text("💊 약 먹기")
                    .font(.title)

                Spacer()

                Text("30분 일정")
            }
            
            HStack {
                Text("21:00 알림 예정")
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 1, x: 5, y: 5)
    }
}

struct DailyNoticeCell_Previews: PreviewProvider {
    static var previews: some View {
        DailyNoticeCell()
    }
}
