//
//  NotifisorApp.swift
//  Notifisor
//
//  Created by dale on 2022/10/12.
//

import SwiftUI

@main
struct NotifisorApp: App {
    let notificationManager = NotificationManager.shared
    let notificationRepository = NoticeRepository.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notificationManager)
                .environmentObject(notificationRepository)
        }
    }
}

