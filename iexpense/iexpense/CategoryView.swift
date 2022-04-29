//
//  CategoryView.swift
//  iexpense
//
//  Created by Tan Tan on 4/29/22.
//

import SwiftUI

struct CategoryView: View {
    var title: String
    @Binding var selected: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
                .font(.headline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10, style: .circular)
                .foregroundColor(selected ? .yellow : .gray.opacity(0.5)))
    }
}
