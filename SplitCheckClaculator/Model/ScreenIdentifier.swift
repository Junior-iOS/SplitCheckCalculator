//
//  ScreenIdentifier.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 24/01/23.
//

import Foundation

struct ScreenIdentifier {
    
    enum LogoView: String {
        case logoView
    }
    
    enum ResultView: String {
        case totalAmountPerPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
    }
    
    enum BillInputView: String {
        case textField
    }
    
    enum TipView: String {
        case tenPercentButton
        case fifteenPercentButton
        case twentyPercentButton
        case customButton
        case customTipAlertTextField
    }
    
    enum SplitView: String {
        case decreaseButton
        case increaseButton
        case quantityLabel
    }
}
