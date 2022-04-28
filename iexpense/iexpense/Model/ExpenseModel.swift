//
//  ExpenseModel.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import Foundation
import RealmSwift

class ExpenseModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var value: Double = 0.0
    @Persisted var category: ExpenseCategory = .other
    
    convenience init(value: Double, category: ExpenseCategory) {
        self.init()
        self.value = value
        self.category = category
    }
    
}

enum ExpenseCategory: Int, PersistableEnum, CaseIterable {
    
    case other
    case food
    case house
    case children
    
    var title: String {
        switch self {
        case .other:
            return "Other"
        case .food:
            return "Food"
        case .house:
            return "House"
        case .children:
            return "Children"
        }
    }
    
    var icon: String {
        switch self {
        case .other:
            return "💰"
        case .food:
            return "🍔"
        case .house:
            return "🏡"
        case .children:
            return "👶🏻"
        }
    }
}
