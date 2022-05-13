//
//  SignInView.swift
//  iexpense
//
//  Created by Tan Tan on 5/13/22.
//

import SwiftUI

struct SignInView: View {
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

            AppleSignInButton()
                .frame(height: 60)
            
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
