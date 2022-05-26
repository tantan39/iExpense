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
            if let currentUser = self.auth.currentUser, currentUser.id == self.auth.user?.id {
                PageView()
                    .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
            } else {
                SignInView()
            }
        }
        .onAppear(perform: {
            if let data = UserDefaults.standard.object(forKey: "User") as? Data {
                let decoder = JSONDecoder()
                if let savedData = try? decoder.decode(User.self, from: data) {
                    self.auth.user = savedData
                }
            }
        })
        .environmentObject(auth)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
