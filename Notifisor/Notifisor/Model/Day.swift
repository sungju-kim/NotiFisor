//
//  Day.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/11/09.
//

import Foundation
import RealmSwift

final class Day: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id = ""
    @Persisted var date: Date
    @Persisted var notices: List<CurrentNotice>
    var achievementRate: Double {
        let total = Double(notices.count)
        let isDone = Double(notices.filter { $0.isDone }.count)
        return isDone == 0 ? 0 : isDone / total
    }
}
