//
//  HomeView.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
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

struct HomeView: View {
    @State var categorySelected: ExpenseCategory = .other
    
    var body: some View {
        VStack {
            NumberPadView()
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 30) {
                    ForEach(ExpenseCategory.allCases, id: \.self) { category in
                        
                        CategoryView(title: category.icon + category.title, selected: .constant(categorySelected == category))
                            .onTapGesture {
                                categorySelected = category
                            }
                    }
                }
                .frame(height: 100)
            }
            .padding(.leading)
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
