//
//  AuthenticateService.swift
//  iexpense
//
//  Created by Tan Tan on 5/19/22.
//

import Foundation

struct User {
    let id: String
    let displayName: String?
    let isAnonymous: Bool
}

protocol AuthenticateService {
    func anonymousSignIn() async throws -> User?
}
