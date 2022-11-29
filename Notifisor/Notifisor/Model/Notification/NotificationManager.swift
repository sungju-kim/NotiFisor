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

    func getPendingRequests() {
        notiCenter.getPendingNotificationRequests { noties in
            print("pending: \(noties.count)")
        }
        notiCenter.getDeliveredNotifications { noties in
            print("Delivered: \(noties.count)")
        }
    }

    func createRequest(_ identifier: String, body: String, at date: Date?, weekday: Int? = nil) {
        guard let date = date else { return }
        let key: Set<Calendar.Component> = (weekday == nil) ? [.year, .month, .day, .hour, .minute] : [.hour, .minute]
        var dateComponents = Calendar.current.dateComponents(key, from: date)
        dateComponents.weekday = weekday
        dateComponents.timeZone = .current

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: weekday != nil)
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

    func deleteRequest(_ identifier: [String]) {
        notiCenter.removePendingNotificationRequests(withIdentifiers: identifier)
    }

    func getIdentifier(from notice: NoticeType) -> [String] {
        guard let notice = notice as? Notice else { return [] }
        var result = ["\(notice.title) \(notice.noticeTime)-\(0)"]
        if !notice.repeats.isEmpty { result = notice.repeats.map { "\(notice.title) \(notice.noticeTime)-\($0)" } }
        return result
    }
}
