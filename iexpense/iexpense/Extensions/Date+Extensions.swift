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
        return dateFormatter.string(from: self)
    }
}
