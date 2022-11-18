//
//  RepeatSectionCell.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/13.
//

import SwiftUI

struct RepeatSectionCell: View {
    @Binding var repeatDay: RepeatDay

    var body: some View {
        Button {
            repeatDay.isSelected.toggle()
        } label: {
            HStack {
                Text("\(repeatDay.week.text)마다")
                    .foregroundColor(.primary)
                Spacer()
                if repeatDay.isSelected {
                    Image(systemName: "checkmark")
                        .tint(.primary)
                }
            }
        }
    }
}
