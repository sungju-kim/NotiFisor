//
//  NoticeType.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/11/09.
//

import Foundation
import RealmSwift

class NoticeType: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var amount: Double?
    @Persisted var noticeTime: Date
    @Persisted var unit: Unit
    @Persisted var repeats: List<Int>
}
