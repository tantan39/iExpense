//
//  ExpenseListView.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import SwiftUI
import RealmSwift

struct ExpenseListView: View {
    @State var expenseValue: String = ""
    @State var category: ExpenseCategory = .other
    
    @ObservedResults(ExpenseModel.self) var items
    
    var body: some View {
        VStack {
            List {
                ForEach (items, id: \.id) { item in
                    HStack {
                        Text(item.category.icon)
                        let value = String(format: "$%.2f", item.value)
                        Text(value)
                    }
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
