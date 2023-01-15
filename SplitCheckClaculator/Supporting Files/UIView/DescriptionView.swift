//
//  DescriptionView.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 14/01/23.
//

import Foundation
import UIKit

final class DescriptionView: UIView {
    
    let top: String
    let bottom: String
    
    private lazy var topLabel: UILabel = {
        LabelFactory.build(text: top, font: ThemeFont.bold(ofSize: 18), backgroundColor: ThemeColor.background)
    }()
    
    private lazy var bottomLabel: UILabel = {
        LabelFactory.build(text: bottom, font: ThemeFont.regular(ofSize: 16), backgroundColor: ThemeColor.background)
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topLabel, bottomLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        return stack
    }()
    
    init(top: String, bottom: String) {
        self.top = top
        self.bottom = bottom
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DescriptionView: CodeView {
    func buildHierarchy() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {}
}
