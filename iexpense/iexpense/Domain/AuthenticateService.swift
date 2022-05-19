//
//  AuthenticateService.swift
//  iexpense
//
//  Created by Tan Tan on 5/19/22.
//

import Foundation
import Firebase

struct User {
    let id: String
    let displayName: String?
    let isAnonymous: Bool
    
    init(_ user: FirebaseAuth.User) {
        self.id = user.uid
        self.displayName = user.displayName
        self.isAnonymous = user.isAnonymous
    }
}

protocol AuthenticateService {
    func anonymousSignIn() async throws -> User?
}
