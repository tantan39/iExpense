//
//  ExpenseListView.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import SwiftUI
import RealmSwift
import Combine

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
            }
        }
    }
}

struct ExpenseListView: View {
    @ObservedObject var viewModel: ExpenseListViewModel = ExpenseListViewModel()
    @State var showEdit: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach ($viewModel.groupItems, id: \.id) { group in
                    Section {
                        ForEach (group.items, id: \.id) { item in
                            ExpenseCellView(item: item)
                                .onTapGesture {
                                    self.viewModel.editItem = item.wrappedValue
                                    showEdit.toggle()
                                }
                        }
                        .listRowSeparator(.hidden)
                    } header: {
                        HStack {
                            Text(group.wrappedValue.date.display)
                                .font(.headline)
                            Spacer()
                            Text(viewModel.totalExpense(by: group.wrappedValue))
                                .font(.headline)
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
        .sheet(isPresented: $showEdit) {
            HomeView(
                viewModel: HomeViewViewModel(expense: self.viewModel.editItem!),
                padViewModel: NumberPadViewModel(
                    value: "\(self.viewModel.editItem?.value ?? 0.0)",
                    note: self.viewModel.editItem?.note ?? ""))
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
