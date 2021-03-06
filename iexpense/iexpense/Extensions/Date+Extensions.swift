//
//  Date+Extensions.swift
//  iexpense
//
//  Created by Tan Tan on 5/4/22.
//

import Foundation

extension Date {
    var display: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM YYYY"
        
        var day: String = ""
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            day = "Today"
        } else if calendar.isDateInYesterday(self) {
            day = "Yesterday"
        } else {
            dateFormatter.dateFormat = "EEEE \nMMM YYYY"
            return dateFormatter.string(from: self)
        }
        
        return day + "\n" + dateFormatter.string(from: self)
    }
    
    func getTime() -> (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        var calendar = Calendar.current
        if let timeZone = TimeZone(identifier: "EST") {
           calendar.timeZone = timeZone
        }

        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        let second = calendar.component(.second, from: self)
        return (year, month, day, hour, minute, second)
    }
    
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }
    
    func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
}
