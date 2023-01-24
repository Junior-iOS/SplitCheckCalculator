//
//  ScreenIdentifier.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 24/01/23.
//

import Foundation

struct ScreenIdentifier {
    enum ResultView: String {
        case totalAmountPerPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
        
        public func getValue() -> String {
            return rawValue
        }
    }
}
