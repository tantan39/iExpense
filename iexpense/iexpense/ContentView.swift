//
//  ContentView.swift
//  iexpense
//
//  Created by Tan Tan on 4/27/22.
//

import SwiftUI
import RealmSwift

class ExpenseModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var value: Double = 0.0
    @Persisted var category: ExpenseCategory = .other
    
    convenience init(value: Double, category: ExpenseCategory) {
        self.init()
        self.value = value
        self.category = category
    }
    
}

enum ExpenseCategory: Int, PersistableEnum, CaseIterable {
    
    case other
    case food
    case house
    case children
    
    var title: String {
        switch self {
        case .other:
            return "Other"
        case .food:
            return "Food"
        case .house:
            return "House"
        case .children:
            return "Children"
        }
    }
    
    var icon: String {
        switch self {
        case .other:
            return "💰"
        case .food:
            return "🍔"
        case .house:
            return "🏡"
        case .children:
            return "👶🏻"
        }
    }
}

struct ContentView: View {
    @State var expenseValue: String = ""
    @State var category: ExpenseCategory = .other
    
    @ObservedResults(ExpenseModel.self) var items
    
    var body: some View {
        VStack {
            
            List {
                ForEach (items, id: \.id) { item in
                    HStack {
                        Text("$\(item.value)")
                        Spacer()
                        Text(item.category.icon)
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
