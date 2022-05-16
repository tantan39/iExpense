//
//  ExpenseLoader.swift
//  iexpense
//
//  Created by Tan Tan on 5/16/22.
//

import Foundation

protocol ExpenseLoader {
    func fetchExpenses() async throws -> [ExpenseModel]
    func addExpense(_ item: ExpenseModel)
}
