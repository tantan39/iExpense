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
                        .foregroundColor(.white)
                        .offset(x: -10, y: 0)
                }
            }
            .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(selected ? .gray : .black))
            .animation(.default, value: selected)

        }

    }
}
