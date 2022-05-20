//
//  SignInView.swift
//  iexpense
//
//  Created by Tan Tan on 5/13/22.
//

import SwiftUI
import Firebase

struct SignInView: View {
    @EnvironmentObject var auth: ExpenseAuth
    @ObservedObject var viewModel = SignInViewModel()
    
    var body: some View {
        VStack {
            Image(systemName:"dollarsign.circle")
                .resizable()
                .frame(width: 150, height: 150)
                .aspectRatio(contentMode: .fit)
                .padding(.top, 20)
            
            HStack {
                Text("Welcome to")
                    .font(.title)
                Text("iExpense")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            .padding(.top, 40)
            
            Spacer()
            
            Button {
                Task {
                    let user = try await viewModel.signInAnonymously()
                    auth.user = user
                    auth.isAuthenticated = true
                }
                
            } label: {
                Text("Sign In as a Anonymous")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(RoundedRectangle(cornerRadius: 6)
                            .foregroundColor(Color.black))

//            AppleSignInButton()
//                .frame(height: 60)
            
            Divider()
                .padding(.top, 20.0)
                .padding(.bottom, 15.0)
            
            Text("By using Reminder you agree to our Terms of Use and Service Policy")
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
