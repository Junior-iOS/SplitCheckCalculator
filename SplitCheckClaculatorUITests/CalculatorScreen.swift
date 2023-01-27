//
//  CalculatorScreen.swift
//  SplitCheckClaculatorUITests
//
//  Created by Junior Silva on 24/01/23.
//

import Foundation
import XCTest

class CalculatorScreen {
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    // MARK: - LOGO VIEW
    var logoView: XCUIElement {
        app.otherElements[ScreenIdentifier.LogoView.logoView.rawValue]
    }
    
    // MARK: - RESULT VIEW
    var totalAmountPerPersonValueLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue]
    }
    
    var totalBillValueLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.ResultView.totalBillValueLabel.rawValue]
    }
    
    var totalTipValueLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.ResultView.totalTipValueLabel.rawValue]
    }
    
    // MARK: - BILL INPUT VIEW
    var billInputViewTextField: XCUIElement {
        app.textFields[ScreenIdentifier.BillInputView.textField.rawValue]
    }
    
    // MARK: - TIP VIEW
    var tenPercentButton: XCUIElement {
        app.buttons[ScreenIdentifier.TipView.tenPercentButton.rawValue]
    }
    
    var fifteenPercentButton: XCUIElement {
        app.buttons[ScreenIdentifier.TipView.fifteenPercentButton.rawValue]
    }
    
    var twentyPercentButton: XCUIElement {
        app.buttons[ScreenIdentifier.TipView.twentyPercentButton.rawValue]
    }
    
    var customTipButton: XCUIElement {
        app.buttons[ScreenIdentifier.TipView.customButton.rawValue]
    }
    
    var customTipAlertTextField: XCUIElement {
        app.textFields[ScreenIdentifier.TipView.customTipAlertTextField.rawValue]
    }
    
    // MARK: - SPLIT VIEW
    var decreaseButton: XCUIElement {
        app.buttons[ScreenIdentifier.SplitView.decreaseButton.rawValue]
    }
    
    var increaseButton: XCUIElement {
        app.buttons[ScreenIdentifier.SplitView.increaseButton.rawValue]
    }
    
    var quantityLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.SplitView.quantityLabel.rawValue]
    }
    
    // MARK: - actions
    
    func doubleTapLogoView() {
        logoView.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    }
    
    func enterBill(_ amount: Double) {
        billInputViewTextField.tap()
        billInputViewTextField.typeText("\(amount)\n")
    }
    
    func selectTip(_ tip: Tip) {
        switch tip {
        case .tenPercent:
            tenPercentButton.tap()
        case .fifteenPercent:
            fifteenPercentButton.tap()
        case .twentyPercent:
            twentyPercentButton.tap()
        case .custom(let value):
            customTipButton.tap()
            XCTAssertTrue(customTipAlertTextField.waitForExistence(timeout: 1))
            customTipAlertTextField.typeText("\(value)\n")
        }
    }
    
    func selectIncreaseButton(numberOfTaps: Int) {
        increaseButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    func selectDecreaseButton(numberOfTaps: Int) {
        decreaseButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    enum Tip {
        case tenPercent
        case fifteenPercent
        case twentyPercent
        case custom(value: Int)
    }
}
