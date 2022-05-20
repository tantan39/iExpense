//
//  ExpenseLoader.swift
//  iexpense
//
//  Created by Tan Tan on 5/16/22.
//

import Foundation

protocol ExpenseLoader {
    func fetchExpenses(userId: String, completion: @escaping (Result<[ExpenseModel], Error>) -> Void)
    func addExpense(_ item: ExpenseModel)
    func updateExpense(_ item: ExpenseModel)
    func deleteExpense(_ item: ExpenseModel)
}
