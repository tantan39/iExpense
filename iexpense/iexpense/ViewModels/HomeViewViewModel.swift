//
//  HomeViewViewModel.swift
//  iexpense
//
//  Created by Tan Tan on 4/29/22.
//

import Foundation
import RealmSwift
class HomeViewViewModel: ObservableObject {
    @ObservedResults(ExpenseModel.self) var items
    
    @Published var expenseValue: String = ""
    @Published var note: String? = ""
    @Published var categorySelected: ExpenseCategory = .other
    @Published var date: Date = .init()
    
    func addExpense() {
        let item = ExpenseModel(value: Double(expenseValue) ?? 0.0, category: categorySelected, date: date, note: note)
        
        $items.append(item)
    }
}
