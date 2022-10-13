//
//  HistoryNoticeCell.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import SwiftUI

struct HistoryNoticeCell: View {
// TODO: - viewModel import 후 변경 예정
    let title: String = "💊 약먹기"
    let resolvedTime: String = "12 : 40"
    let isResolved: Bool = true

    var body: some View {
        HStack {
            Text("\(title)")
                .font(.title)

            Spacer()

            Text("\(resolvedTime)")
                .font(.title)
                .foregroundColor(isResolved ? .blue : .gray)
        }
        .padding()
        .background(.ultraThickMaterial)
        .background(isResolved ? .yellow : .white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 1, x: 5, y: 5)

    }
}

struct HistoryNoticeCell_Previews: PreviewProvider {
    static var previews: some View {
        HistoryNoticeCell()
    }
}
