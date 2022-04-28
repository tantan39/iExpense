//
//  ContentView.swift
//  iexpense
//
//  Created by Tan Tan on 4/27/22.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
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
            
            HStack {
                TextField("New Item", text: $expenseValue)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                Picker("", selection: $category) {
                    ForEach(ExpenseCategory.allCases, id: \.self) { cat in
                        Text(cat.title)
                            .tag(cat)
                    }
                }
                .pickerStyle(.menu)

                Button {
                    let item = ExpenseModel(value: Double(expenseValue) ?? 0.0, category: category)
                    $items.append(item)
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
