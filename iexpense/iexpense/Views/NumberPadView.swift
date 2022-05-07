//
//  NumberPadView.swift
//  iexpense
//
//  Created by Tan Tan on 4/27/22.
//

import SwiftUI
struct NumberPadView: View {
    
    var colums = [GridItem(.adaptive(minimum: 90, maximum: 90), spacing: 30, alignment: .center)]
    
    @ObservedObject var viewModel: NumberPadViewModel
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.value.isEmpty ? "$0.00" : viewModel.value.toCurrencyFormat())
                    .fontWeight(.semibold)
                    .font(.largeTitle)
                    .padding(.leading, -4)
            }
            .padding(.top, 30)
            
            TextField(viewModel.note.isEmpty ? "Add Note" : viewModel.note, text: $viewModel.note)
                .foregroundColor(.gray)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            LazyVGrid(columns: colums) {
                ForEach($viewModel.items, id: \.self) { item in
                    if item.wrappedValue.type == .erase {
                        Text("\(item.wrappedValue.title)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
//                            .frame(width: 90, height: 90)
                        
                            .foregroundColor(viewModel.value.isEmpty ? .gray : .black)
                            .padding()
                            .disabled(viewModel.value.isEmpty)
                            .onTapGesture {
                                self.viewModel.updateValue(item.wrappedValue)
                            }
                    } else {
                        Text("\(item.wrappedValue.title)")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
//                            .frame(width: 90, height: 90)
                            .padding()
                            .onTapGesture {
                                self.viewModel.updateValue(item.wrappedValue)
                            }
                    }
                }
            }
            .padding(.top, 20)
            
        }
    }

}

struct NumberPadView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPadView(viewModel: NumberPadViewModel())
    }
}
