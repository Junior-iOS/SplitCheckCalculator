//
//  CodeView.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 07/01/23.
//

import Foundation

protocol CodeView {
    func buildHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setup()
}

extension CodeView {
    func setup() {
        buildHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
