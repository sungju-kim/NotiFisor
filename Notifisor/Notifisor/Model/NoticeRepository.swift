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
    let realm: Realm
    
    private init() {
        do {
            self.realm = try Realm()
            try realm.write {
                for i in 1...7 {
                    realm.create(Weekday.self, value: ["id": i], update: .modified)
                }

                if get(Day.self, Date.now.id) == nil {
                    let today = Date.now
                    guard let weekday = get(Weekday.self, today.get(.weekday)) as? Weekday else { return }
                    let temp = List<CurrentNotice>()
                    weekday.notices.forEach { temp.append($0.toCurrent()) }
                    realm.create(Day.self, value: ["_id": today.id, "date": today, "notices": temp], update: .modified)
                }
            }
        } catch {
            fatalError("DB load failure")
        }
    }

    func add(_ notice: NoticeType) {
        do {
            try realm.write {
                guard let notice = notice as? Notice else { return }
                for i in notice.repeats {
                    realm.objects(Weekday.self)[i-1].notices.append(notice)
                }

                if notice.repeats.contains(Date.now.get(.weekday)) || notice.repeats.isEmpty {
                    guard let day = realm.object(ofType: Day.self, forPrimaryKey: Date.now.id)  else { return }
                    day.notices.append(notice.toCurrent())
                }

            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

    func get<Element: Object, KeyType>(_ type: Element.Type, _ id: KeyType) -> Element? {
        return realm.object(ofType: type, forPrimaryKey: id)
    }

    func updateInfo(_ oldObject: NoticeType, _ newObject: NoticeType) {
        delete(oldObject)
        add(newObject)
    }

    func delete(_ object: NoticeType) {
        guard let day = get(Day.self, Date.now.id) as? Day else { return }

        if let object = object as? CurrentNotice {
            do {
                try realm.write {
                    if let notice = get(Notice.self, object.rootId) as? Notice {
                        realm.delete(notice)
                    }

                    if let current = day.notices.where { $0.rootId == object.rootId }.first {
                        realm.delete(current)
                    }
                }
            } catch {
                fatalError("failure at delteing a item")
            }

        } else {
            do {
                try realm.write {
                    if let notice = get(Notice.self, object._id) as? Notice {
                        realm.delete(notice)
                    }

                    if let current = day.notices.where { $0.rootId == object._id }.first {
                        realm.delete(current)
                    }
                }
            } catch {
                fatalError("failure at delteing a item")
            }
        }

    }
}
