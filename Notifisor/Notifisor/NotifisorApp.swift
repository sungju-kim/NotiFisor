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
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notificationManager)
                .environmentObject(notificationRepository)
                .onChange(of: scenePhase) { if $0 == .active { notificationRepository.refresh() } }
                .onAppear {
                    if let lastLogin = UserDefaults.standard.object(forKey: "lastLogin") as? Date {
                        notificationRepository.createDay(from: lastLogin, to: Date.now)
                    }
                    UserDefaults.standard.set(Date.now, forKey: "lastLogin")
                }
        }
    }
}

