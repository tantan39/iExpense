//
//  FireStoreExpenseService.swift
//  iexpense
//
//  Created by Tan Tan on 5/16/22.
//

import Foundation
import Firebase

class FireStoreExpenseService: ExpenseLoader {
    let db = Firestore.firestore()
    
    func addExpense(_ item: ExpenseModel) {
        let model = ExpenseRemoteModel(id: .init(), value: item.value, category: item.category, paymentMethod: item.paymentMethod, date: item.date, note: item.note)
        
        db.collection("Expense").addDocument(data: [
            "id": model.id.uuidString,
            "value": model.value,
            "category": model.category.rawValue,
            "payment": model.paymentMethod.rawValue,
            "date": model.date,
            "note": model.note ?? ""]) { error in
                if let err = error {
                    print("Error adding document: \(err)")
                }
            }
    }
}
