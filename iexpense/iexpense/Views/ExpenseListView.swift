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
    @EnvironmentObject var auth: ExpenseAuth
    @State var homeType: HomeType?
    
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
                                    .foregroundColor(Color("darkGray"))
                            }
                            
                            Button {
                                viewModel.timeRange = .lastMonth
                            } label: {
                                Text(TimeRange.lastMonth.title)
                                    .foregroundColor(Color("darkGray"))
                            }

                            Button {
                                viewModel.timeRange = .thisYear
                            } label: {
                                Text(TimeRange.thisYear.title)
                                    .foregroundColor(Color("darkGray"))
                            }
                            
                            Button {
                                viewModel.timeRange = .lastYear
                            } label: {
                                Text(TimeRange.lastYear.title)
                                    .foregroundColor(Color("darkGray"))
                            }
                        } label: {
                            HStack {
                                Text(viewModel.timeRange.title)
                                    .font(.title)
                                    .foregroundColor(Color("darkGray"))
                                    .fontWeight(.bold)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color("darkGray"))
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("Total")
                                .foregroundColor(Color("darkGray"))
                                .font(.title)
                                .fontWeight(.bold)
                            let value = String(format: "$%.2f", viewModel.total)
                            Text(value)
                                .foregroundColor(Color("darkGray"))
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
                                        .foregroundColor(Color("darkGray"))
                                    Spacer()
                                }
                                
                                Text(group.wrappedValue.date.display)
                                    .foregroundColor(Color("darkGray"))
                                    .font(.headline)
                                    .lineSpacing(-4)
                                Spacer()
                                Text(viewModel.totalExpense(by: group.wrappedValue))
                                    .font(.headline)
                                    .foregroundColor(Color("darkGray"))
                            }
                            .padding(.bottom, 10)
                            
                            Divider()
                            
                            ForEach (group.items, id: \.id) { item in
                                ExpenseCellView(item: item)
                                    .padding(.bottom)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        homeType = .update(item.wrappedValue)
                                    }
                            }
                            .listRowSeparator(.hidden)
                        }
                    }
                }
                .emptyState($viewModel.filteringGroupItems.isEmpty) {
                    Text("No expenses")
                }
            }
        }
        .onAppear(perform: {
            guard let user = auth.user else { return }
            viewModel.fetchExpenses(user)
        })
        .sheet(item: $homeType, onDismiss: {
            guard let user = auth.user else { return }
            viewModel.fetchExpenses(user)
        }, content: { hometype in
            hometype
        })

    }
}

struct ExpenseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseListView()
    }
}

#if DEBUG
let items: [ExpenseModel] = [
    ExpenseModel(value: 200, category: .debtLoan, paymentMethod: .creditCard, date: .init(), note: "a Note", userId: UUID().uuidString),
    ExpenseModel(value: 28.50, category: .children, paymentMethod: .creditCard, date: .init(), note: "another Note", userId: UUID().uuidString),
    ExpenseModel(value: 1500, category: .family, paymentMethod: .cash, date: .init(), note: nil, userId: UUID().uuidString),
    ExpenseModel(value: 11.58, category: .grocery, paymentMethod: .digitalWallet, date: .init(), note: "a Note", userId: UUID().uuidString),
]
#endif
