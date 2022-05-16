//
//  iexpenseApp.swift
//  iexpense
//
//  Created by Tan Tan on 4/27/22.
//

import SwiftUI
import Resolver

@main
struct iexpenseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register {
            FireStoreExpenseService() as ExpenseLoader
        }
        .scope(.application)

        .scope(.application)
    }
}
