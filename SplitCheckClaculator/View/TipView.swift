//
//  TipView.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 07/01/23.
//

import Foundation
import UIKit

final class TipView: UIView {
    
    private let descriptionView: DescriptionView = {
        let view = DescriptionView(top: "Choose", bottom: "your tip")
        return view
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = buildTipButton(with: .tenPercent)
        return button
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = buildTipButton(with: .fifteenPercent)
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(with: .twentyPercent)
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom Tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(8)
        return button
    }()
    
    private lazy var hStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [tenPercentTipButton, fifteenPercentTipButton, twentyPercentTipButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()
    
    private lazy var vStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [hStackView, customTipButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
//        stack.backgroundColor = ThemeColor.background
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    private func buildTipButton(with tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(8)
        addShadow(offset: CGSize(width: 0, height: 3), color: .black, radius: 12.0, opacity: 0.1)
        
        let text = NSMutableAttributedString(string: tip.value, attributes: [
            .font: ThemeFont.bold(ofSize: 20),
            .foregroundColor: UIColor.white
        ])
        text.addAttributes([
            .font: ThemeFont.demibold(ofSize: 14)
        ], range: NSMakeRange(2, 1))
        
        button.setAttributedTitle(text, for: .normal)
        return button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TipView: CodeView {
    func buildHierarchy() {
        addSubviews(descriptionView, vStackView)
    }
    
    func setupConstraints() {
        vStackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        descriptionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(vStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
            make.centerY.equalTo(hStackView.snp.centerY)
        }
    }
    
    func setupAdditionalConfiguration() {}
}
