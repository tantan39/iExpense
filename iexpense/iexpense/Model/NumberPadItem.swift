//
//  NumberPadItem.swift
//  iexpense
//
//  Created by Tan Tan on 4/28/22.
//

import Foundation

struct NumberPadItem: Hashable {
    let title: String
    let type: PadItemType
    
    enum PadItemType {
        case number
        case dot
        case erase
    }
}
