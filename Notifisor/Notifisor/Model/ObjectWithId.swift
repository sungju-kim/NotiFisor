//
//  ObjectWithId.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/11/16.
//

import Foundation
import RealmSwift

class ObjectWithId: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
}
