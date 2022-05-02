//
//  CategoryView.swift
//  iexpense
//
//  Created by Tan Tan on 4/29/22.
//

import SwiftUI

struct CategoryView: View {
    var title: String
    var selectedColor: Color = .yellow
    
    @Binding var selected: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
                .font(.headline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundColor(selected ? selectedColor : .gray.opacity(0.5)))
    }
}
