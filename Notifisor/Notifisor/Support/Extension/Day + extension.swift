//
//  Day + extension.swift
//  Notifisor
//
//  Created by YEONGJIN JANG on 2022/10/20.
//

import CoreData
import Foundation

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
