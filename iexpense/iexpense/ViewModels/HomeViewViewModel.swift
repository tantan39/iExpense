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
    
    @Published var item: ExpenseModel = ExpenseModel(value: 0.0, category: .debtLoan, paymentMethod: .creditCard, date: .init(), note: "")
//    @Published var expenseValue: String = ""
//    @Published var note: String? = ""
//    @Published var categorySelected: ExpenseCategory = .debtLoan
//    @Published var paymentMethod: PaymentMethod = .creditCard
//    @Published var date: Date = .init()
    
    var strDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd-YYYY"
        
        let calendar = Calendar.current
        if calendar.isDateInToday(item.date) {
            return "Add for Today"
        } else if calendar.isDateInYesterday(item.date) {
            return "Add for Yesterday"
        }
        
        return "Add for \(dateFormatter.string(from: item.date))"
    }
    
    func setCategory(_ category: ExpenseCategory) {
        item.category = category
        objectWillChange.send()
    }
    
    func setPaymentMethod(_ method: PaymentMethod) {
        item.paymentMethod = method
        objectWillChange.send()
    }
    
    func addExpense() {
        $items.append(item)
    }
    
    func update(_ item: ExpenseModel) {
        if let _ = items.firstIndex(where: { $0.id == item.id }) {
            do {
                let realm = try Realm()
                let expense = realm.object(ofType: ExpenseModel.self, forPrimaryKey: item.id)
                try realm.write {
                    expense?.value = item.value
                    expense?.note = item.note
                    expense?.category = item.category
                    expense?.paymentMethod = item.paymentMethod
                    expense?.date = item.date
                }
            } catch {
                
            }
        }
    }
}
