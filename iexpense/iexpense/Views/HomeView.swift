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
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var auth: ExpenseAuth
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                if let editItem = viewModel.editItem {
                    HStack {
                        Button {
                            viewModel.delete(editItem)
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "trash.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.red)
                        }
                        
                        Spacer()
                        
                        Text("Edit Transaction")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }

                    }
                    .padding()
                }
                
                NumberPadView(viewModel: padViewModel)
                    .padding(.bottom, 10)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 30) {
                        ForEach(ExpenseCategory.allCases, id: \.self) { category in
                            CategoryView(title: category.icon + " " +  category.title, selected: .constant(viewModel.categorySelected == category))
                                .onTapGesture {
                                    viewModel.categorySelected = category
                                }
                        }
                    }
                    .frame(height: 60)
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 30) {
                        ForEach(PaymentMethod.allCases, id: \.self) { method in
                            
                            CategoryView(title: method.icon + " " +  method.title, selectedColor: .accentColor, selected: .constant(viewModel.paymentMethod == method))
                                .onTapGesture {
                                    viewModel.paymentMethod = method
                                }
                        }
                    }
                    .frame(height: 60)
                }
                .padding(.horizontal)
                
                Spacer()
                    
                HStack {
                    
                    DatePickerButtonView(date: $viewModel.date)
                        .frame(width: 60, height: 60)
                    
                    Button {
                        if let editItem = viewModel.editItem {
                            viewModel.update(editItem)
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            viewModel.addExpense()
                            padViewModel.value = ""
                            padViewModel.note = ""
                        }
                        
                    } label: {
                        Text(viewModel.strDate)
                            .fontWeight(.bold)
                            .font(.title3)
                            .frame(width: 260, height: 30)
                            .padding()
                    }
                    .buttonStyle(MainButtonStyle())
                    .disabled(!padViewModel.isValidated)
                    
                }
                
            }
        }
        .onAppear(perform: {
            viewModel.auth = auth
        })
        .onReceive(padViewModel.$value, perform: { value in
            guard !value.isEmpty else { return }
            viewModel.expenseValue = value
        })
        .onReceive(padViewModel.$note) { note in
            guard !note.isEmpty else { return }
            viewModel.note = note
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
