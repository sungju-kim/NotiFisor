//
//  Notice+CoreDataProperties.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/11/08.
//
//

import Foundation
import CoreData


extension Notice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notice> {
        return NSFetchRequest<Notice>(entityName: "Notice")
    }

    @NSManaged public var amount: Int64
    @NSManaged public var isDone: Bool
    @NSManaged public var noticeTime: Date?
    @NSManaged public var repeats: [Int]?
    @NSManaged public var title: String?
    @NSManaged public var day: Day?
    @NSManaged public var unit: Unit

}

extension Notice: Identifiable {
    
}
