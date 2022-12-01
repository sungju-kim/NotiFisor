//
//  View + extension.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/12/01.
//

import Foundation
import SwiftUI

/// 음영효과를 주는 Custom Modifier
// MARK: - Custom Modifier
extension View {
    func shadowCellStyle() -> some View {
        modifier(ShadowCell())
    }
}
