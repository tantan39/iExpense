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
    
    func fetchExpenses() async throws -> [ExpenseModel] {
        var results: [ExpenseRemoteModel] = []
        do {
            let _ = try db.collection("Expense").addDocument(from: model)
        } catch {
            print("Error adding document: \(error)")
        }
    }
    
    func updateExpense(_ item: ExpenseModel) {
        
    }
    
    func deleteExpense(_ item: ExpenseModel) {
        if let id = item.id {
            db.collection("Expense").document(id).delete()
        }
    }
}
