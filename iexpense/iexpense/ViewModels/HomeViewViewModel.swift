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
    
    var editItem: ExpenseModel?
    @Published var expenseValue: String = ""
    @Published var note: String? = ""
    @Published var categorySelected: ExpenseCategory = .debtLoan
    @Published var paymentMethod: PaymentMethod = .creditCard
    @Published var date: Date = .init()
    let realm = try! Realm()
    
    init(expense: ExpenseModel? = nil) {
        guard let expense = expense else { return }
        self.editItem = expense
        self.expenseValue = "\(expense.value)"
        self.note = expense.note
        self.categorySelected = expense.category
        self.paymentMethod = expense.paymentMethod
        self.date = expense.date
        
    }
    
    var strDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd-YYYY"
        
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Add for Today"
        } else if calendar.isDateInYesterday(date) {
            return "Add for Yesterday"
        }
        
        return "Add for \(dateFormatter.string(from: date))"
    }
    
    func addExpense() {
        let item = ExpenseModel(value: Double(expenseValue) ?? 0.0,
                                category: categorySelected,
                                paymentMethod: paymentMethod,
                                date: date,
                                note: note)
        $items.append(item)
    }
    
    func update(_ item: ExpenseModel) {
        let realm = try! Realm()
        let expense = realm.object(ofType: ExpenseModel.self, forPrimaryKey: item.id)
        do {
            try realm.write {
                expense?.value = Double(self.expenseValue) ?? 0.0
                expense?.note = self.note
                expense?.category = self.categorySelected
                expense?.paymentMethod = self.paymentMethod
                expense?.date = self.date
            }
        } catch {
            print("Fail to write")
        }
    }
    
    func delete(_ item: ExpenseModel) {
        let realm = try! Realm()
        guard let expense = realm.object(ofType: ExpenseModel.self, forPrimaryKey: item.id) else { return }
        do {
            try realm.write {
                realm.delete(expense)
                self.objectWillChange.send()
            }
        } catch {
            print("Fail to write")
        }
    }
}
