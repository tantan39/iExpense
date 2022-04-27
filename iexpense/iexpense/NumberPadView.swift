//
//  NumberPadView.swift
//  iexpense
//
//  Created by Tan Tan on 4/27/22.
//

import SwiftUI

struct NumberPadItem: Hashable {
    let title: String
    let type: PadItemType
    
    enum PadItemType {
        case number
        case dot
        case erase
    }
}

struct NumberPadView: View {
    @State var value: String = " "
    var colums = [GridItem(.adaptive(minimum: 100, maximum: 100), spacing: 10, alignment: .center)]
    @State var enableCent: Bool = false
    @State var centNumberCount: Int = 0
    
    var items: [NumberPadItem] = [
        NumberPadItem(title: "1", type: .number),
        NumberPadItem(title: "2", type: .number),
        NumberPadItem(title: "3", type: .number),
        NumberPadItem(title: "4", type: .number),
        NumberPadItem(title: "5", type: .number),
        NumberPadItem(title: "6", type: .number),
        NumberPadItem(title: "7", type: .number),
        NumberPadItem(title: "8", type: .number),
        NumberPadItem(title: "9", type: .number),
        NumberPadItem(title: ".", type: .dot),
        NumberPadItem(title: "0", type: .number),
        NumberPadItem(title: "⌫", type: .erase)
    ]
    var body: some View {
        VStack {
            Text(value)
                .font(.largeTitle)
                
            LazyVGrid(columns: colums) {
                ForEach(items, id: \.self) { item in
                    Text("\(item.title)")
                        .font(.largeTitle)
                        .frame(width: 100, height: 100)
                        .background(Color.teal)
                        .onTapGesture {
                            updateValue(item)
                        }
                }
            }
        }
    }
    
    func updateValue(_ item: NumberPadItem) {
        switch item.type {
        case .number:
            if enableCent {
                if centNumberCount < 2 {
                    value += "\(item.title)"
                    centNumberCount += 1
                }
                return
            } else {
                value += "\(item.title)"
            }
            
        case .dot:
            guard !enableCent else { return }
            
            value += "\(item.title)"
            enableCent.toggle()
        case .erase:
            value.removeLast()
            if value.contains(".") {
                enableCent = true
                centNumberCount -= 1
            } else {
                enableCent = false
                centNumberCount = 0
            }
        }
    }
}

struct NumberPadView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPadView()
    }
}
