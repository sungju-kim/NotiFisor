//
//  NoticeRepository.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/11/10.
//

import Foundation
import RealmSwift

//TODO: - 에러 핸들링
final class NoticeRepository: ObservableObject {
    static let shared = NoticeRepository()
    private let realm: Realm

    private var weekday: Weekday?
    var day: Day?
    private init() {
        do {
            self.realm = try Realm()
        } catch {
            fatalError("DB Load Failure")
        }

        refresh()
    }

    func refresh() {
        self.weekday = get(Weekday.self, Date.kst.get(.weekday))
        self.day = get(Day.self, Date.kst.id)

        if weekday == nil { createWeekDay() }
        if day == nil { createDay() }
    }

    private func createWeekDay() {
        write {
            (1...7).forEach { realm.create(Weekday.self,
                                           value: ["id": $0],
                                           update: .modified) }
        }
    }

    private func createDay() {
        write {
            let today = Date.kst
            let totalNotices = List<CurrentNotice>()
            weekday?.notices.forEach { totalNotices.append($0.toCurrent()) }

            realm.create(Day.self,
                         value: ["_id": today.id, "date": today, "notices": totalNotices],
                         update: .modified)
            self.day = get(Day.self, Date.kst.id)
        }
    }


    func write(_ completion: () -> Void) {
        do {
            try realm.write(completion)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

    func add(_ notice: Notice) {
        write {
            notice.repeats.forEach { get(Weekday.self, $0)?.notices.append(notice) }

            if notice.repeats.contains(Date.kst.get(.weekday)) || notice.repeats.isEmpty {
                day?.notices.append(notice.toCurrent())
            }
        }
    }

    func get<Element: Object, KeyType>(_ type: Element.Type, _ id: KeyType) -> Element? {
        return realm.object(ofType: type, forPrimaryKey: id)
    }

    func updateInfo(_ oldObject: NoticeType, _ newObject: Notice) {
        delete(oldObject)
        add(newObject)
    }

    func delete<T: NoticeType>(_ object: T) {
        write {
            if let notice = get(Notice.self, object.targetId) {
                realm.delete(notice)
            }

            if let current = day?.notices.where({ $0.rootId == object.targetId }).first {
                realm.delete(current)
            }
        }
    }
}
