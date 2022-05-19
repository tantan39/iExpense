//
//  UserProfileView.swift
//  iexpense
//
//  Created by Tan Tan on 5/19/22.
//

import SwiftUI

struct UserProfileView: View {
    @Binding var user: User?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            
            Text("ID: " + (user?.id ?? ""))
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
                .padding(.top, 20)

            Text(user?.displayName ?? "")
                .font(.title2)
                .foregroundColor(.gray)
                .fontWeight(.semibold)
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Log out")
                    .foregroundColor(.teal)
            }
            
            
        }
        .padding()
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(user: .constant(nil))
    }
}
