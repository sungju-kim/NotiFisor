//
//  RepeatSectionCell.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/13.
//

import SwiftUI

struct RepeatSectionCell: View {
    @State var isSelected: Bool = false
    let title: String
    
    var body: some View {
        Button {
            isSelected.toggle()
        } label: {
            HStack {
                Text(title)
                    .foregroundColor(.black)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .tint(.black)
                    
                }
            }
        }
    }
}

struct RepeatSectionCell_Previews: PreviewProvider {
    static var previews: some View {
        RepeatSectionCell(title: "monday")
    }
}
