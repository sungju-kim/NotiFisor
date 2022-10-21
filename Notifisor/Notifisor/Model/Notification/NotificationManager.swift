//
//  NotificationManager.swift
//  Notifisor
//
//  Created by dale on 2022/10/19.
//

import Foundation
import UserNotifications

final class NotificationManager: ObservableObject {
    static let shared = NotificationManager()

    private let notiCenter = UNUserNotificationCenter.current()
    private var content: UNMutableNotificationContent = {
        let content = UNMutableNotificationContent()
        content.title = "오늘 일정 마무리 하셨나요?"
        content.sound = .default
        return content
    }()

    private init() {
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

    func createRequest(_ identifier: String, body: String, at date: Date?, weekday: Int) {
        guard let date = date else { return }

        var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        dateComponents.weekday = weekday
        dateComponents.timeZone = .current

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: true)
        content.body = body

        let request = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: trigger)

        notiCenter.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }

    func deleteRequest(_ identifier: String) {
        notiCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
