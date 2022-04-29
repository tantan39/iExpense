//
//  HomeView.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import SwiftUI
import RealmSwift
import Combine

struct CategoryView: View {
    var title: String
    @Binding var selected: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
                .font(.headline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10, style: .circular)
                .foregroundColor(selected ? .yellow : .gray.opacity(0.5)))
    }
}

struct HomeView: View {
    @State var expenseValue: String = ""
    @State var categorySelected: ExpenseCategory = .other
    @State var date: Date = .init()
    @State var note: String? = ""
    @ObservedObject var padViewModel: NumberPadViewModel = NumberPadViewModel()
    @ObservedResults(ExpenseModel.self) var items
        
    var body: some View {
        let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
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
            .padding(.leading)
            
            HStack {
                DatePickerButtonView(date: $date)
                    .frame(width: 60, height: 60)
                
                Button {
                    let item = ExpenseModel(value: Double(expenseValue) ?? 0.0, category: categorySelected, date: date, note: note)
                    $items.append(item)

                } label: {
                    Text("Add for Today")
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 30)
                        .padding()
                }
                .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(Color.accentColor))
                
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
