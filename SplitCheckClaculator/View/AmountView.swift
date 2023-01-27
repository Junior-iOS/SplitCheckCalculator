//
//  AmountView.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 14/01/23.
//

import Foundation
import UIKit

final class AmountView: UIView {
    
    let title: String
    let textAlignment: NSTextAlignment
    let amountLabelIdentifier: String
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(text: title,
                           font: ThemeFont.demibold(ofSize: 18),
                           textColor: ThemeColor.text,
                           textAlignment: textAlignment,
                           backgroundColor: .white)
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.textColor = ThemeColor.primary
        let text = NSMutableAttributedString(string: "R$ 0", attributes: [
            .font: ThemeFont.bold(ofSize: 24)
        ])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 16)
        ], range: NSMakeRange(0, 2))
        label.attributedText = text
        label.accessibilityIdentifier = amountLabelIdentifier
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, amountLabel])
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    init(title: String, textAlignment: NSTextAlignment, amountLabelIdentifier: String) {
        self.title = title
        self.textAlignment = textAlignment
        self.amountLabelIdentifier = amountLabelIdentifier
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(amount: Double) {
        let text = NSMutableAttributedString(
            string: amount.formattedCurrency,
            attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes(
            [.font: ThemeFont.bold(ofSize: 16)],
            range: NSMakeRange(0, 2))
        amountLabel.attributedText = text
    }
}

extension AmountView: CodeView {
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
