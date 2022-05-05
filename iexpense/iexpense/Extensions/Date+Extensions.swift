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
        dateFormatter.dateFormat = "MMM dd"
        
        var day: String = ""
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            day = "Today"
        } else if calendar.isDateInYesterday(self) {
            day = "Yesterday"
        } else {
            dateFormatter.dateFormat = "MMM dd - EEEE"
            return dateFormatter.string(from: self)
        }
        
        return dateFormatter.string(from: self) + " - " + day
    }
}
