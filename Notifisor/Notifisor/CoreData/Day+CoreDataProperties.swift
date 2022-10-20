//
//  Day+CoreDataProperties.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/20.
//
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var achievementRate: Float
    @NSManaged public var date: Date?
    @NSManaged public var month: Month?
    @NSManaged public var notices: NSSet?

}

// MARK: Generated accessors for notices
extension Day {

    @objc(addNoticesObject:)
    @NSManaged public func addToNotices(_ value: Notice)

    @objc(removeNoticesObject:)
    @NSManaged public func removeFromNotices(_ value: Notice)

    @objc(addNotices:)
    @NSManaged public func addToNotices(_ values: NSSet)

    @objc(removeNotices:)
    @NSManaged public func removeFromNotices(_ values: NSSet)

}

extension Day : Identifiable {

}

extension Day: Comparable {
    public static func <(lhs: Day, rhs: Day) -> Bool {
        guard let lhsDate = lhs.date,
              let rhsDate = rhs.date
        else {
            fatalError("dates are invalid")
        }
        return lhsDate < rhsDate
    }
}
