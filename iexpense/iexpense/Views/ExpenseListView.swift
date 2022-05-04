//
//  ExpenseListView.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import SwiftUI
import RealmSwift
import Combine

extension Date {
    var display: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd yyyy"
        return dateFormatter.string(from: self)
    }
}

struct ExpenseCellView: View {
    @Binding var item: ExpenseModel
    
    var body: some View {
        VStack {
            Text(item.date.display)
            HStack {
                Text(item.category.icon)
                    .font(.largeTitle)
                VStack(alignment: .leading) {
                    Text(item.category.title)
                        .font(.headline)
                    
                    if let note = item.note {
                        Text(note)
                            .fontWeight(.light)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                let value = String(format: "$%.2f", item.value)
                Text(value)
                    .font(.headline)
            }
        }
    }
}

class ExpenseListViewModel: ObservableObject {
    @ObservedResults(ExpenseModel.self, sortDescriptor: SortDescriptor.init(keyPath: "date", ascending: false)) private var expenseModels
    @Published var items: [ExpenseModel] = []
    @Published var groupItems: [Date: [ExpenseModel]] = [:]
    
    private var cancellabels = Set<AnyCancellable>()
    
    init() {
        expenseModels.objectWillChange.sink { _ in
            self.items = self.expenseModels.map { $0 }
        }
        .store(in: &cancellabels)
    }
}

struct ExpenseListView: View {
    @ObservedObject var viewModel: ExpenseListViewModel = ExpenseListViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach ($viewModel.items, id: \.id) { item in
                    Section {
                        ExpenseCellView(item: item)
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

#if DEBUG
let items: [ExpenseModel] = [
    ExpenseModel(value: 200, category: .debtLoan, paymentMethod: .creditCard, date: .init(), note: "a Note"),
    ExpenseModel(value: 28.50, category: .children, paymentMethod: .creditCard, date: .init(), note: "another Note"),
    ExpenseModel(value: 1500, category: .family, paymentMethod: .cash, date: .init(), note: nil),
    ExpenseModel(value: 11.58, category: .grocery, paymentMethod: .digitalWallet, date: .init(), note: "a Note"),
]
#endif
