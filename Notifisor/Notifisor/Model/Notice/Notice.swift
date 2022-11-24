//
//  Notice.swift
//  Notifisor
//
//  Created by dale on 2022/11/24.
//

import Foundation
import RealmSwift

final class Notice: NoticeType {
    func toCurrent() -> CurrentNotice {
        let result = CurrentNotice()
        result.rootId = _id
        result.title = title
        result.amount = amount
        result.unit = unit
        result.noticeTime = noticeTime
        result.repeats = repeats
        result.isDone = false
        return result
    }
}
