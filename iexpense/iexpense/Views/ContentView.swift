//
//  ContentView.swift
//  iexpense
//
//  Created by Tan Tan on 4/27/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @ObservedObject var auth: ExpenseAuth = ExpenseAuth()
    
    var body: some View {
        Group {
            if auth.isAuthenticated {
                PageView()
                    .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
            } else {
                SignInView()
            }
        }
        .environmentObject(auth)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
