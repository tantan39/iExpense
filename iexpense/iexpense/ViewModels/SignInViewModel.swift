//
//  SignInViewModel.swift
//  iexpense
//
//  Created by Tan Tan on 5/16/22.
//

import Combine
import Firebase
import SwiftUI

class SignInViewModel: ObservableObject {
    func signInAnonymously() async throws -> User? {
        do {
            let authDataResult = try await Auth.auth().signInAnonymously()
            return authDataResult.user
        } catch {
            debugPrint("Sign in fail")
        }
        
        return nil
    }
}
