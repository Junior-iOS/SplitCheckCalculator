//
//  UIResponder+Extensions.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 18/01/23.
//

import Foundation
import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
