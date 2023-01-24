//
//  SplitCheckClaculatorUITests.swift
//  SplitCheckClaculatorUITests
//
//  Created by Junior Silva on 07/01/23.
//

import XCTest

final class SplitCheckClaculatorUITests: XCTestCase {

    private var app: XCUIApplication!
    
    private var screen: CalculatorScreen {
        CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testResultViewDefaultValues() {
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "R$0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "R$0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "R$0")
    }
}
