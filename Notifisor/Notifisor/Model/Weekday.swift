//
//  Weekday.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/11/09.
//

import Foundation
import RealmSwift

final class Weekday: Object {
    @Persisted var sunday: List<Notice>
    @Persisted var monday: List<Notice>
    @Persisted var tuesday: List<Notice>
    @Persisted var wednesday: List<Notice>
    @Persisted var thursday: List<Notice>
    @Persisted var friday: List<Notice>
    @Persisted var saturday: List<Notice>
}
