//
//  ExpenseCellView.swift
//  iexpense
//
//  Created by Tan Tan on 5/12/22.
//

import SwiftUI

struct ExpenseCellView: View {
    @Binding var item: ExpenseModel
    
    var body: some View {
        VStack {
            HStack {
                Text(item.category.icon)
                    .font(.largeTitle)
                VStack(alignment: .leading) {
                    Text(item.category.title)
                        .font(.headline)
                        .foregroundColor(Color("darkGray"))
                    
                    if let note = item.note, !note.isEmpty {
                        Text(note)
                            .fontWeight(.light)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                let value = String(format: "$%.2f", item.value)
                Text(value)
                    .font(.headline)
                    .foregroundColor(Color("darkGray"))
            }
        }
    }
}
