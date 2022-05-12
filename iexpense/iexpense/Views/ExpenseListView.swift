//
//  ExpenseListView.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import SwiftUI
import RealmSwift
import Combine

struct ExpenseListView: View {
    @ObservedObject var viewModel: ExpenseListViewModel = ExpenseListViewModel()
    @State var showEdit: Bool = false
    
    var body: some View {
        VStack {
            List {
                Section {
                    HStack {
                        Menu {
                            Button {
                                viewModel.timeRange = .thisMonth
                            } label: {
                                Text(TimeRange.thisMonth.title)
                            }
                            
                            Button {
                                viewModel.timeRange = .lastMonth
                            } label: {
                                Text(TimeRange.lastMonth.title)
                            }

                            Button {
                                viewModel.timeRange = .thisYear
                            } label: {
                                Text(TimeRange.thisYear.title)
                            }
                            
                            Button {
                                viewModel.timeRange = .lastYear
                            } label: {
                                Text(TimeRange.lastYear.title)
                            }
                        } label: {
                            HStack {
                                Text(viewModel.timeRange.title)
                                    .font(.title)
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.black)
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("Total")
                                .font(.title)
                                .fontWeight(.bold)
                            let value = String(format: "$%.2f", viewModel.total)
                            Text(value)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                }
                
                ForEach ($viewModel.filteringGroupItems, id: \.id) { group in
                    Section {
                        VStack {
                            HStack {
                                VStack {
                                    Text("\(group.wrappedValue.date.getTime().day)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                
                                Text(group.wrappedValue.date.display)
                                    .font(.headline)
                                    .lineSpacing(-4)
                                Spacer()
                                Text(viewModel.totalExpense(by: group.wrappedValue))
                                    .font(.headline)
                            }
                            .padding(.bottom, 10)
                            
                            Divider()
                            
                            ForEach (group.items, id: \.id) { item in
                                ExpenseCellView(item: item)
                                    .padding(.bottom)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        self.viewModel.editItem = item.wrappedValue
                                        showEdit.toggle()
                                    }
                            }
                            .listRowSeparator(.hidden)
                        }
                    } header: {
                        
                    }
                }
            }
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
