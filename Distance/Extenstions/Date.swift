//
//  Date.swift
//  Distance
//
//  Created by Aaron Wilson on 4/19/23.
//

import Foundation
extension Date {
    func startOfWeek(using calendar: Calendar) -> Date {
        calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
}
