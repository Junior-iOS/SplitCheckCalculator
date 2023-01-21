//
//  Double+Extensions.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 20/01/23.
//

import Foundation

extension Double {
    var formattedCurrency: String {
        var isWholeNumber: Bool {
            isZero ? true : !isNormal ? false : self == rounded()
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        return formatter.string(for: self) ?? ""
    }
}
