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
}
