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
}

struct ExpenseListView: View {
    @ObservedObject var viewModel: ExpenseListViewModel = ExpenseListViewModel()
    
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

#if DEBUG
let items: [ExpenseModel] = [
    ExpenseModel(value: 200, category: .debtLoan, paymentMethod: .creditCard, date: .init(), note: "a Note"),
    ExpenseModel(value: 28.50, category: .children, paymentMethod: .creditCard, date: .init(), note: "another Note"),
    ExpenseModel(value: 1500, category: .family, paymentMethod: .cash, date: .init(), note: nil),
    ExpenseModel(value: 11.58, category: .grocery, paymentMethod: .digitalWallet, date: .init(), note: "a Note"),
]
#endif
