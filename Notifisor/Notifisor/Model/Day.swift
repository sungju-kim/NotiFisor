//
//  Day.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/11/09.
//

import Foundation
import RealmSwift

final class Day: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var date: Date
    @Persisted var notices: List<Notice>
    var achievementRate: Double {
        0
    }
}
