//
//  FulfillmentView.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/13.
//

import SwiftUI

struct FulfillmentView: Shape {
    @State var startAngle: Double
    @State var endAngle: Double

    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                        radius: rect.height / 2,
                        startAngle: .degrees(startAngle),
                        endAngle: .degrees(endAngle),
                        clockwise: false)
        }
    }
}
