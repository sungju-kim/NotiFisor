//
//  SectionHeaderText.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/14.
//

import SwiftUI

struct SectionHeaderText: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.title3)
    }
}

struct SectionHeaderText_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeaderText(text: "김호찌")
    }
}
