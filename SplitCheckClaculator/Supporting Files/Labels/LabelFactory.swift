//
//  LabelFactory.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 07/01/23.
//

import Foundation
import UIKit

struct LabelFactory {
    static func build(
        text: String?,
        font: UIFont,
        textColor: UIColor = ThemeColor.text,
        textAlignment: NSTextAlignment = .center,
        backgroundColor: UIColor = .clear) -> UILabel {
            let label = UILabel()
            label.text = text
            label.font = font
            label.textColor = textColor
            label.textAlignment = textAlignment
            label.backgroundColor = backgroundColor
            return label
        }
}
