//
//  AmountView.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 07/01/23.
//

import Foundation
import UIKit

final class ResultView: UIView {
    
    private lazy var headerLabel: UILabel = {
        LabelFactory.build(text: "Total per person", font: ThemeFont.demibold(ofSize: 18), backgroundColor: .white)
    }()
    
    private lazy var amountPerPersonLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "R$ 0",
            attributes: [.font: ThemeFont.bold(ofSize: 48)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSRange(location: 0, length: 2))
        label.attributedText = text
        label.textAlignment = .center
        label.accessibilityIdentifier = ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        return view
    }()
    
    private lazy var totalBillView: AmountView = {
        let view = AmountView(title: "Total bill",
                              textAlignment: .left, 
                              amountLabelIdentifier: ScreenIdentifier.ResultView.totalBillValueLabel.rawValue)
        return view
    }()
    
    private lazy var totalTipView: AmountView = {
        let view = AmountView(title: "Total tip",
                              textAlignment: .right, 
                              amountLabelIdentifier: ScreenIdentifier.ResultView.totalTipValueLabel.rawValue)
        return view
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            totalBillView,
            UIView(),
            totalTipView
        ])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerLabel, amountPerPersonLabel, separatorView, buildSpacerView(height: 0), hStack])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
    
    public func configure(result: Result) {
        let text = NSMutableAttributedString(
            string: result.amountPerPerson.formattedCurrency,
            attributes: [.font: ThemeFont.bold(ofSize: 48)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSRange(location: 0, length: 2))
        amountPerPersonLabel.attributedText = text
        
        totalBillView.configure(amount: result.totalBill)
        totalTipView.configure(amount: result.totalTip)
    }
    
}

// MARK: - CODEVIEW
extension ResultView: CodeView {
    func buildHierarchy() {
        addSubview(vStack)
    }
    
    func setupConstraints() {
        vStack.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.bottom.equalTo(snp.bottom).offset(-24)
        }
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        addShadow(offset: CGSize(width: 0, height: 3), color: .black, radius: 12.0, opacity: 0.1)
    }
}
