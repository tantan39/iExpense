//
//  MenuItemView.swift
//  iexpense
//
//  Created by Tan Tan on 5/5/22.
//

import SwiftUI

struct MenuItemView: View {
    @State var title: String
    @State var icon: String
    @Binding var selected: Bool
    var onClick: (() -> Void)?
    
    var body: some View {
        Button {
            onClick?()
        } label: {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    .padding()
                if selected {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .offset(x: -10, y: 0)
                }
            }
            .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(selected ? .black : .gray))
            .animation(.default, value: selected)

        }

    }
}

struct MenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemView(title: "Transaction", icon: "note.text.badge.plus", selected: .constant(true), onClick: nil)
    }
}
