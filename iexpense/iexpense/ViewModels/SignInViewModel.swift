//
//  SignInViewModel.swift
//  iexpense
//
//  Created by Tan Tan on 5/16/22.
//

import Combine
import Resolver
import Foundation

class SignInViewModel: ObservableObject {
    @Injected var authenticateService: AuthenticateService
    
    func signInAnonymously() async throws -> User? {
        let user = try await authenticateService.anonymousSignIn()
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: "User")
        }
        return user
    }
}
