//
//  InputView.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 07/01/23.
//

import Foundation
import UIKit

final class InputView: UIView {
    
    private let descriptionView: DescriptionView = {
        let view = DescriptionView(top: "Enter", bottom: "your bill")
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(8)
        view.addShadow(offset: CGSize(width: 0, height: 3), color: .black, radius: 12.0, opacity: 0.1)
        return view
    }()
    
    private let currencyLabel: UILabel = {
        let label = LabelFactory.build(text: "R$", font: ThemeFont.bold(ofSize: 24))
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.backgroundColor = .white
        return label
    }()
    
    private lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = ThemeFont.demibold(ofSize: 28)
        textField.keyboardType = .decimalPad
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.tintColor = ThemeColor.text
        textField.textColor = ThemeColor.text
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapDoneButton))
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapDoneButton() {
        amountTextField.endEditing(true)
    }
    
}

extension InputView: CodeView {
    func buildHierarchy() {
        addSubviews(descriptionView, containerView)
        containerView.addSubviews(currencyLabel, amountTextField)
    }
    
    func setupConstraints() {
        descriptionView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.centerY.equalTo(containerView.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(containerView.snp.leading).offset(-16)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        currencyLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.width.equalTo(32)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(currencyLabel.snp.trailing).offset(16)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
        }
    }
    
    func setupAdditionalConfiguration() {}
}
