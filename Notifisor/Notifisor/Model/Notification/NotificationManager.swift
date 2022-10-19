//
//  NotificationManager.swift
//  Notifisor
//
//  Created by dale on 2022/10/19.
//

import Foundation
import UserNotifications

struct NotificationManager {
    let notiCenter = UNUserNotificationCenter.current()
    let content: UNMutableNotificationContent = {
        let content = UNMutableNotificationContent()
        content.title = "알림 제목"
        content.body = "알림 내용"
        content.sound = .default
        return content
    }()

    init() {
        requestAuthrization()
        notiCenter.removeAllDeliveredNotifications()
    }

    func requestAuthrization() {
        notiCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("granted")
            }

            if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }
    }

    func createRequest(_ identifier: String, at date: Date?) {
        guard let date = date else { return }

        let dateComponents = Calendar.current.dateComponents([.weekday, .hour, .minute], from: date)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: true)

        let request = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: trigger)

        notiCenter.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }

    func deleteRequest(_ identifiers: [String]) {
        notiCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}
