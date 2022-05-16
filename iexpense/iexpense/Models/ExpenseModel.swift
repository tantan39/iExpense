//
//  ExpenseModel.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import Foundation
import RealmSwift
import FirebaseFirestoreSwift

struct ExpenseRemoteModel: Codable {
    var id: String?
    let value: Double
    let category: ExpenseCategory
    let paymentMethod: PaymentMethod
    let date: Date
    let note: String?
}

class ExpenseModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var value: Double = 0.0
    @Persisted var category: ExpenseCategory = .other
    @Persisted var paymentMethod: PaymentMethod = .creditCard
    @Persisted var date: Date
    @Persisted var note: String?
    
    convenience init(value: Double, category: ExpenseCategory, paymentMethod: PaymentMethod, date: Date, note: String?) {
        self.init()
        self.value = value
        self.category = category
        self.paymentMethod = paymentMethod
        self.date = date
        self.note = note
    }
    
}

enum ExpenseCategory: Int, PersistableEnum, CaseIterable, Codable {
    
    case debtLoan
    case bills
    case grocery
    case shopping
    case family
    case children
    case gifts
    case transportation
    case travel
    case other
    
    var title: String {
        switch self {
        case .debtLoan:
            return "Dept/Loan"
        case .bills:
            return "Bills & Utilities"
        case .grocery:
            return "Grocery"
        case .shopping:
            return "Shopping"
        case .family:
            return "Family"
        case .children:
            return "Children"
        case .gifts:
            return "Gifts"
        case .transportation:
            return "Transportation"
        case .travel:
            return "Travel"
        case .other:
            return "Other"
        }
    }
    
    var icon: String {
        switch self {
        case .debtLoan:
            return "🏦"
        case .bills:
            return "🧾"
        case .grocery:
            return "🛒"
        case .shopping:
            return "🛍"
        case .family:
            return "🏡"
        case .children:
            return "👶🏻"
        case .gifts:
            return "🎁"
        case .transportation:
            return "🚘"
        case .travel:
            return "🛫"
        case .other:
            return "💰"
        }
    }
}

enum PaymentMethod: Int, PersistableEnum, CaseIterable, Codable {
    
    case creditCard
    case cash
    case digitalWallet
    
    var title: String {
        switch self {
        case .cash:
            return "Cash"
        case .creditCard:
            return "Credit Card"
        case .digitalWallet:
            return "Digital Wallet"
        }
    }
    
    var icon: String {
        switch self {
        case .cash:
            return "💵"
        case .creditCard:
            return "💳"
        case .digitalWallet:
            return "📱"
        }
    }
}
