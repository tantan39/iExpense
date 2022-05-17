//
//  ExpenseAuth.swift
//  iexpense
//
//  Created by Tan Tan on 5/16/22.
//

import Combine
import Firebase

class ExpenseAuth: ObservableObject {
    @Published var user: User?
}