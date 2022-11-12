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
    @Persisted var unit: Unit
}
