//
//  FirebaseAuthenticateService.swift
//  iexpense
//
//  Created by Tan Tan on 5/19/22.
//

import Foundation
import Firebase

class FirebaseAuthenticateService: AuthenticateService {
    func anonymousSignIn() async throws -> User? {
        let authDataResult = try await Auth.auth().signInAnonymously()
        let authUser = authDataResult.user
        let user = User(authUser)
        return user
    }
    
    func logOut() async throws {
        try Auth.auth().signOut()
    }
}
