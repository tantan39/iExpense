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
            let snapshot = try await db.collection("Expense").getDocuments()
            for document in snapshot.documents {
                print("\(document.documentID) => \(document.data())")
                if let item = try? document.data(as: ExpenseRemoteModel.self) {
                    results.append(item)
                }
            }
            
            return results.map { ExpenseModel(value: $0.value, category: $0.category, paymentMethod: $0.paymentMethod, date: $0.date, note: $0.note )}
        } catch {
            print("Got an error \(error.localizedDescription)")
        }
        return []
    }
    
    func addExpense(_ item: ExpenseModel) {
        let model = ExpenseRemoteModel(id: UUID().uuidString, value: item.value, category: item.category, paymentMethod: item.paymentMethod, date: item.date, note: item.note)
        
        db.collection("Expense").addDocument(data: [
            "id": model.id ?? "",
            "value": model.value,
            "category": model.category.rawValue,
            "paymentMethod": model.paymentMethod.rawValue,
            "date": model.date,
            "note": model.note ?? ""]) { error in
                if let err = error {
                    print("Error adding document: \(err)")
                }
            }
    }
}
