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
    
    func fetchExpenses(completion: @escaping (Result<[ExpenseModel], Error>) -> Void) {
        var results: [ExpenseRemoteModel] = []
        db.collection("Expense").order(by: "date", descending: true)
            .addSnapshotListener { querySnapshot, error in
                if let snapshot = querySnapshot {
                    results = snapshot.documents.compactMap({
                        return try? $0.data(as: ExpenseRemoteModel.self)
                    })
                    let items = results.map { ExpenseModel(id: $0.id ?? UUID().uuidString, value: $0.value, category: $0.category, paymentMethod: $0.paymentMethod, date: $0.date, note: $0.note, userId: $0.userId )}
                    completion(.success(items))
                }
            }
    }
    
    func addExpense(_ item: ExpenseModel) {
        let model = ExpenseRemoteModel(value: item.value, category: item.category, paymentMethod: item.paymentMethod, date: item.date, note: item.note, userId: item.userId)
        
        do {
            let _ = try db.collection("Expense").addDocument(from: model)
        } catch {
            print("Error adding document: \(error)")
        }
    }
    
    func updateExpense(_ item: ExpenseModel) {
        if let id = item.id {
            do {
                let model = ExpenseRemoteModel(value: item.value, category: item.category, paymentMethod: item.paymentMethod, date: item.date, note: item.note, userId: item.userId)
                
                let docRef = db.collection("Expense").document(id)
                try docRef.setData(from: model, merge: true)
            } catch {
                
            }
        }
    }
    
    func deleteExpense(_ item: ExpenseModel) {
        if let id = item.id {
            db.collection("Expense").document(id).delete()
        }
    }
}
