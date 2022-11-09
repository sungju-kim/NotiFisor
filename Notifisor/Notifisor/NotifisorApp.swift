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
    let notificationManager = NotificationManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notificationManager)
        }
    }
}

