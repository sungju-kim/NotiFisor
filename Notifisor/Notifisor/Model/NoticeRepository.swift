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
                    realm.create(Day.self, value: ["_id": today.id, "date": today, "notices": weekday.notices], update: .modified)
                }
            }
        } catch {
            fatalError("DB load failure")
        }
    }

    func add(_ object: Object) {
        guard let notice = object as? Notice else { return }
        do {
            try realm.write {
                for i in notice.repeats {
                    realm.objects(Weekday.self)[i-1].notices.append(notice)
                }

                if notice.repeats.contains(Date.now.get(.weekday)) || notice.repeats.isEmpty {
                    guard let day = realm.object(ofType: Day.self, forPrimaryKey: Date.now.id)  else { return }
                    day.notices.append(notice)
                }

            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

    func get<Element: Object, KeyType>(_ type: Element.Type, _ id: KeyType) -> Object? {
        return realm.object(ofType: type, forPrimaryKey: id)
    }

    func updateInfo(_ type: Object.Type, _ id: ObjectId, _ value: [String: Any]) {
        do {
            try realm.write {
                realm.create(type, value: value, update: .modified)
            }
        } catch {
            fatalError("failing info update at \(#file)")
        }
    }

    func updateInfo(_ oldObject: Object, _ newObject: Object) {
        delete(oldObject)
        add(newObject)
    }

    func delete(_ object: Object) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            fatalError("failure at delteing a item")
        }
    }
}
