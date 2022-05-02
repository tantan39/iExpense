//
//  iexpenseTests.swift
//  iexpenseTests
//
//  Created by Tan Tan on 4/27/22.
//

import XCTest
@testable import iexpense

class iexpenseTests: XCTestCase {
    func test_init_emptyValue() {
        let sut = NumberPadViewModel()

        XCTAssertEqual(sut.value, "")
        XCTAssertEqual(sut.hasCentValues, false)
        XCTAssertEqual(sut.centNumberCount, 0)
    }

    func test_updateValue_renderValueInputed() {
        let sut = NumberPadViewModel()
        
        sut.updateValue(NumberPadItem(title: "2", type: .number))
        sut.updateValue(NumberPadItem(title: "5", type: .number))
        sut.updateValue(NumberPadItem(title: "9", type: .number))
        sut.updateValue(NumberPadItem(title: "9", type: .number))
        
        XCTAssertEqual(sut.value, "2599")
    }
    
    func test_updateValue_addCentValue() {
        let sut = NumberPadViewModel()
        
        sut.updateValue(NumberPadItem(title: "2", type: .number))
        sut.updateValue(NumberPadItem(title: "5", type: .number))
        sut.updateValue(NumberPadItem(title: "9", type: .number))
        sut.updateValue(NumberPadItem(title: "9", type: .number))
        
        sut.updateValue(NumberPadItem(title: ".", type: .dot))
        sut.updateValue(NumberPadItem(title: "0", type: .number))
        sut.updateValue(NumberPadItem(title: "4", type: .number))
        sut.updateValue(NumberPadItem(title: "4", type: .number))
        sut.updateValue(NumberPadItem(title: "1", type: .number))
        
        XCTAssertEqual(sut.value, "2599.04")
    }
    
    func test_updateValue_earseLastNumberWithCentValue() {
        let sut = NumberPadViewModel()

        sut.updateValue(NumberPadItem(title: "2", type: .number))
        sut.updateValue(NumberPadItem(title: "5", type: .number))

        sut.updateValue(NumberPadItem(title: ".", type: .dot))
        sut.updateValue(NumberPadItem(title: "0", type: .number))
        sut.updateValue(NumberPadItem(title: "4", type: .number))
        sut.updateValue(NumberPadItem(title: "⌫", type: .erase))
        sut.updateValue(NumberPadItem(title: "⌫", type: .erase))
        sut.updateValue(NumberPadItem(title: "⌫", type: .erase))
        XCTAssertEqual(sut.value, "25")
        sut.updateValue(NumberPadItem(title: ".", type: .dot))
        sut.updateValue(NumberPadItem(title: "1", type: .number))
        sut.updateValue(NumberPadItem(title: "1", type: .number))
        sut.updateValue(NumberPadItem(title: "3", type: .number))
        XCTAssertEqual(sut.value, "25.11")
    }
    
    func test_updateValue_inputCentValueWithoutEvenNumber() {
        let sut = NumberPadViewModel()
        sut.updateValue(NumberPadItem(title: ".", type: .dot))
        sut.updateValue(NumberPadItem(title: "1", type: .number))
        sut.updateValue(NumberPadItem(title: "1", type: .number))
        XCTAssertEqual(sut.value, "11")
    }
}
