//
//  Notice.swift
//  Notifisor
//
//  Created by dale on 2022/10/13.
//

import Foundation

struct Notice: Hashable {
    let title: String
    let amount: Int
    let unit: Unit
    let noticeTime: Date
    let repeatAction: [Repeat]
    var isDone: Bool = false
    var schedule: String {
        return "\(amount)\(unit.text) 일정"
    }
}

typealias Notices = [Notice]
