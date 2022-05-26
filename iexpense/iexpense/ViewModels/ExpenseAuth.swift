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

    var currentUser: User? {
        if let user = Auth.auth().currentUser {
            self.user = User(user)
            return self.user
        }
        return nil
    }
}
