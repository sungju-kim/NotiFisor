//
//  Notice.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/11/09.
//

import Foundation
import RealmSwift

final class Notice: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var amount: Int
    @Persisted var isDone: Bool
    @Persisted var noticeTime: Date
    @Persisted var repeats: List<Int>
    //TODO: - 지울것 Unit 적용안되고 있음
    private dynamic var unit = Unit.hour.rawValue
    var unitEnum: Unit {
        get {
            return Unit(rawValue: unit) ?? Unit.hour
        }
        set {
            unit = newValue.rawValue
        }
    }
}
