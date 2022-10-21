//
//  RepeatSectionView.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/13.
//

import SwiftUI

struct RepeatSectionView: View {
    @Binding var days: [RepeatDay]
    
    var body: some View {
        List {
            ForEach(0..<days.count) { index in
                HStack {
                    RepeatSectionCell(repeatDay: $days[index])
                }
            }
        }
    }
}
