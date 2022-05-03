//
//  ExpenseListView.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import SwiftUI
import RealmSwift

struct ExpenseCellView: View {
    @Binding var item: ExpenseModel
    
    var body: some View {
        VStack {
            HStack {
                Text(item.category.icon)
                let value = String(format: "$%.2f", item.value)
                Text(value)
            }
            
            if let note = item.note {
                Text(note)
                    .padding(.leading, 40)
            }
        }
    }
}

class ExpenseListViewModel: ObservableObject {
    @ObservedResults(ExpenseModel.self) var items
    
    var body: some View {
        VStack {
            List {
                ForEach (viewModel.items, id: \.id) { item in
                    ExpenseCellView(item: .constant(item))
                }
            }
        }
    }
}

struct ExpenseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseListView()
    }
}
