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
    let isAnnonymous: Bool
}

protocol AuthenticateService {
    func annonymousSignIn() async throws -> User?
}
