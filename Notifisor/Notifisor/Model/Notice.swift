//
//  Notice.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/11/09.
//

import Foundation
import RealmSwift

final class Notice: ObjectWithId {
    @Persisted var title: String
    @Persisted var amount: Double?
    @Persisted var isDone: Bool = false
    @Persisted var noticeTime: Date
    @Persisted var repeats: List<Int>
    @Persisted var unit: Unit
}
