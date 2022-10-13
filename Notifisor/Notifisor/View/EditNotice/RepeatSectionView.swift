//
//  RepeatSectionView.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/13.
//

import SwiftUI

struct RepeatSectionView: View {
    @State var items: [Repeat] = Repeat.allCases
    
    var body: some View {
        List {
            ForEach(items, id: \.self) {
                RepeatSectionCell(title: $0.rawValue)
            }
        }
    }
}

struct RepeatSectionView_Previews: PreviewProvider {
    static var previews: some View {
        RepeatSectionView()
    }
}
