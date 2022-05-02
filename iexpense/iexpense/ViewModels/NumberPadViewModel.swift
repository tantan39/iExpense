//
//  NumberPadViewModel.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import Foundation

class NumberPadViewModel: ObservableObject {
    @Published var items: [NumberPadItem] = [
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
    
    @Published var value: String = ""
    @Published var note: String = ""
    @Published var hasCentValues: Bool = false
    @Published var centNumberCount: Int = 0
    private let inputMaxCount = 9
    
    var isValidated: Bool {
        guard let doubleValue = Double(value) else { return false }
        return doubleValue > 0.0
    }
    
    func updateValue(_ item: NumberPadItem) {
        switch item.type {
        case .number:
            if hasCentValues {
                if centNumberCount < 2 {
                    value += "\(item.title)"
                    centNumberCount += 1
                }
                return
            } else {
                guard value.count < inputMaxCount else { return }
                value += "\(item.title)"
            }
            
        case .dot:
            guard !hasCentValues && value.count > 1 else { return }
            
            value += "\(item.title)"
            hasCentValues.toggle()
        case .erase:
            guard !value.isEmpty else { return }
            value.removeLast()
            if value.contains(".") {
                hasCentValues = true
                centNumberCount -= 1
            } else {
                hasCentValues = false
                centNumberCount = 0
            }
        }
    }
}

extension String{
     func toCurrencyFormat() -> String {
        if let doubleValue = Double(self){
           let numberFormatter = NumberFormatter()
           numberFormatter.locale = Locale(identifier: "en_US")
           numberFormatter.numberStyle = NumberFormatter.Style.currency
           return numberFormatter.string(from: NSNumber(value: doubleValue)) ?? ""
      }
    return ""
  }
}
