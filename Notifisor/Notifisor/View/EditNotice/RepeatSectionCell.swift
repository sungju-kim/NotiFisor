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
                Text(repeatDay.weekDay.rawValue)
                    .foregroundColor(.black)
                Spacer()
                if repeatDay.isSelected {
                    Image(systemName: "checkmark")
                        .tint(.black)
                }
            }
        }
    }
}
