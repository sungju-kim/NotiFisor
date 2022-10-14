//
//  BlackImage.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/14.
//

import SwiftUI

struct BlackImage: View {
    var source: String

    var body: some View {
        Image(systemName: source)
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(.black)
    }
}

struct BlackImage_Previews: PreviewProvider {
    static var previews: some View {
        BlackImage(source: "checkmark")
    }
}
