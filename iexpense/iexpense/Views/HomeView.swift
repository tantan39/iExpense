//
//  HomeView.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import SwiftUI
import Combine

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewViewModel = HomeViewViewModel()
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
            .padding()
            
            Spacer()
            
            HStack {
                DatePickerButtonView(date: $viewModel.date)
                    .frame(width: 60, height: 60)
                
                Button {
                    viewModel.addExpense()
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
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 30, trailing: 8))

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
