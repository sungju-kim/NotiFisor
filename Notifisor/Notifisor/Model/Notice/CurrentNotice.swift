//
//  CurrentNotice.swift
//  Notifisor
//
//  Created by dale on 2022/11/24.
//

import Foundation
import RealmSwift

final class CurrentNotice: NoticeType {
    @Persisted var isDone: Bool = false
    @Persisted var rootId: ObjectId

    override var targetId: ObjectId {
        return rootId
    }
}

extension CurrentNotice: Comparable {
    static func < (lhs: CurrentNotice, rhs: CurrentNotice) -> Bool {
        return lhs.title < rhs.title
    }
}
