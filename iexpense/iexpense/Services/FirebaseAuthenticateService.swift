//
//  FirebaseAuthenticateService.swift
//  iexpense
//
//  Created by Tan Tan on 5/19/22.
//

import Foundation
import Firebase

class FirebaseAuthenticateService: AuthenticateService {
    func annonymousSignIn() async throws -> User? {
        let authDataResult = try await Auth.auth().signInAnonymously()
        let authUser = authDataResult.user
        let user = User(id: authUser.uid, displayName: authUser.displayName, isAnnonymous: authUser.isAnonymous)
        return user
    }
}
