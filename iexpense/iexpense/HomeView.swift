//
//  HomeView.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import SwiftUI
import RealmSwift
import Combine

struct HomeView: View {
    @State var expenseValue: String = ""
    @State var categorySelected: ExpenseCategory = .other
    @State var date: Date = .init()
    @State var note: String? = ""
    @ObservedObject var padViewModel: NumberPadViewModel = NumberPadViewModel()
    @ObservedResults(ExpenseModel.self) var items
    @State var date1 = Date()
    
    var body: some View {
        VStack {
            NumberPadView(viewModel: padViewModel)
                .padding(.bottom, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 30) {
                    ForEach(ExpenseCategory.allCases, id: \.self) { category in
                        
                        CategoryView(title: category.icon + category.title, selected: .constant(categorySelected == category))
                            .onTapGesture {
                                categorySelected = category
                            }
                    }
                }
                .frame(height: 100)
            }
            .padding(.horizontal)
            
            HStack {
                DatePickerButtonView(date: $date)
                    .frame(width: 60, height: 60)
                
                Button {
                    let item = ExpenseModel(value: Double(expenseValue) ?? 0.0, category: categorySelected, date: date, note: note)
                    $items.append(item)
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
            expenseValue = value
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
