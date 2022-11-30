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
            Realm.Configuration.defaultConfiguration = NoticeRepository.migration()
            self.realm = try Realm()
        } catch(let error) {
            fatalError(error.localizedDescription)
        }

        self.weekday = get(Weekday.self, Date.now.get(.weekday))
        self.day = get(Day.self, Date.now.id)

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
            let today = Date.now
            let totalNotices = List<CurrentNotice>()
            weekday?.notices.forEach { totalNotices.append($0.toCurrent()) }

            realm.create(Day.self,
                         value: ["_id": today.id, "date": today, "notices": totalNotices],
                         update: .modified)
            self.day = get(Day.self, Date.now.id)
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

            if notice.repeats.contains(Date.now.get(.weekday)) || notice.repeats.isEmpty {
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
    
    static func migration() -> Realm.Configuration {
        let schemaVersion = 1
        
        let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                migration.enumerateObjects(ofType: Day.className()) { oldObject, newObject in
                    
                    let oldNotice = oldObject!["notices"] as! RealmSwift.List<DynamicObject>
                    let currnetNotice = newObject!["notices"] as! RealmSwift.List<MigrationObject>
                    for notice in oldNotice {
                        let current = migration.create(CurrentNotice.className(), value: [
                            "rootId": notice._id,
                            "title": notice.title,
                            "amount": notice.amount,
                            "unit": notice.unit,
                            "noticeTime": notice.noticeTime,
                            "repeats": notice.repeats,
                            "isDone": false,
                        ])
                        currnetNotice.append(current)
                    }
                    
                }
            }
        }
        return Realm.Configuration(
            schemaVersion: UInt64(schemaVersion),
            migrationBlock: migrationBlock
        )
        
    }
}
