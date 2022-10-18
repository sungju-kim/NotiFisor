//
//  NotifisorApp.swift
//  Notifisor
//
//  Created by dale on 2022/10/12.
//

import SwiftUI
import CoreData


@main
struct NotifisorApp: App {
    let notices = [
        Notice(title: "약먹기", amount: 3, unit: .times, noticeTime: Date.now, repeatAction: [.everyFriday, .everyMonday]),
        Notice(title: "달리기", amount: 3, unit: .km, noticeTime: Date.now, repeatAction: [.everyMonday, .everyTuesday, .everySaturday]),
        Notice(title: "책읽기", amount: 1, unit: .times, noticeTime: Date.now, repeatAction: [.everySunday, .everySaturday])
    ]

    var body: some Scene {
        WindowGroup {
            ContentView(notices: notices)
        }
    }
}
