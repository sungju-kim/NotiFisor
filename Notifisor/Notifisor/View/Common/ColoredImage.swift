//
//  BlackImage.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/14.
//

import SwiftUI

struct ColoredImage: View {
    let source: String
    let color: Color = .black

    var body: some View {
        Image(systemName: source)
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(color)
    }
}
