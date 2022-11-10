//
//  Weekday.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/11/09.
//

import Foundation
import RealmSwift

final class Weekday: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var notices: List<Notice>
}
