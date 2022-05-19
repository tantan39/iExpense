//
//  SignInViewModel.swift
//  iexpense
//
//  Created by Tan Tan on 5/16/22.
//

import Combine
import Resolver

class SignInViewModel: ObservableObject {
    @Injected var authenticateService: AuthenticateService
    
    func signInAnonymously() async throws -> User? {
        return try await authenticateService.anonymousSignIn()
    }
}
