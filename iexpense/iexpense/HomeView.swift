//
//  HomeView.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import SwiftUI
import RealmSwift
import Combine

class HomeViewModel: ObservableObject {
    @ObservedResults(ExpenseModel.self) var items
    
    @Published var expenseValue: String = ""
    @Published var note: String? = ""
    @Published var categorySelected: ExpenseCategory = .other
    @Published var date: Date = .init()
    
    func addExpense(_ item: ExpenseModel?) {
        guard let item = item else {
            return
        }
        $items.append(item)
    }
}

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    @ObservedObject var padViewModel: NumberPadViewModel = NumberPadViewModel()
    
    var body: some View {
        VStack {
            NumberPadView(viewModel: padViewModel)
                .padding(.bottom, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 30) {
                    ForEach(ExpenseCategory.allCases, id: \.self) { category in
                        
                        CategoryView(title: category.icon + category.title, selected: .constant(viewModel.categorySelected == category))
                            .onTapGesture {
                                viewModel.categorySelected = category
                            }
                    }
                }
                .frame(height: 100)
            }
            .padding(.horizontal)
            
            HStack {
                DatePickerButtonView(date: $viewModel.date)
                    .frame(width: 60, height: 60)
                
                Button {
                    let item = ExpenseModel(value: Double(viewModel.expenseValue) ?? 0.0, category: viewModel.categorySelected, date: viewModel.date, note: viewModel.note)
                    viewModel.addExpense(item)
                    padViewModel.value = ""

                } label: {
                    Text("Add for Today")
                        .fontWeight(.bold)
                        .font(.title3)
                        .frame(width: 300, height: 30)
                        .padding()
                }
                .buttonStyle(MainButtonStyle())
                .disabled(padViewModel.value.isEmpty)
                Spacer()
            }
            .padding()
            Spacer()
        }
        .onReceive(padViewModel.$value, perform: { value in
            guard !value.isEmpty else { return }
            viewModel.expenseValue = value
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
