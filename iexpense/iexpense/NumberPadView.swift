//
//  NumberPadView.swift
//  iexpense
//
//  Created by Tan Tan on 4/27/22.
//

import SwiftUI

struct NumberPadView: View {
    
    var colums = [GridItem(.adaptive(minimum: 100, maximum: 100), spacing: 10, alignment: .center)]
    
    @ObservedObject var viewModel = NumberPadViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.value.isEmpty ? "$0.00" : viewModel.value.toCurrencyFormat())
                    .fontWeight(.semibold)
                    .font(.largeTitle)
                    .padding(.leading, -4)
            }
                
            LazyVGrid(columns: colums) {
                ForEach($viewModel.items, id: \.self) { item in
                    if item.wrappedValue.type == .erase {
                        Text("\(item.wrappedValue.title)")
                            .font(.largeTitle)
                            .frame(width: 100, height: 100)
                            .background(Color.teal)
                            .foregroundColor(viewModel.value.isEmpty ? .gray : .black)
                            .disabled(viewModel.value.isEmpty)
                            .onTapGesture {
                                self.viewModel.updateValue(item.wrappedValue)
                            }
                    } else {
                        Text("\(item.wrappedValue.title)")
                            .font(.largeTitle)
                            .frame(width: 100, height: 100)
                            .background(Color.teal)
                            .onTapGesture {
                                self.viewModel.updateValue(item.wrappedValue)
                            }
                    }
                }
            }
        }
    }

}

struct NumberPadView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPadView()
    }
}
