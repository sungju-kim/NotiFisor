//
//  Month+CoreDataProperties.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/19.
//
//

import Foundation
import CoreData


extension Month {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Month> {
        return NSFetchRequest<Month>(entityName: "Month")
    }

    @NSManaged public var date: Date?
    @NSManaged public var days: NSSet?

}

// MARK: Generated accessors for days
extension Month {

    @objc(addDaysObject:)
    @NSManaged public func addToDays(_ value: Day)

    @objc(removeDaysObject:)
    @NSManaged public func removeFromDays(_ value: Day)

    @objc(addDays:)
    @NSManaged public func addToDays(_ values: NSSet)

    @objc(removeDays:)
    @NSManaged public func removeFromDays(_ values: NSSet)

}

extension Month : Identifiable {

}
