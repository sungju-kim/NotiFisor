//
//  CellModifier.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/12/01.
//

import SwiftUI

struct ShadowCell: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 1, x: 5, y: 5)
    }
}
