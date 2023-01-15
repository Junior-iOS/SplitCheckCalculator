//
//  CalculatorViewController.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 07/01/23.
//

import UIKit
import SnapKit

class CalculatorViewController: UIViewController {
    
    private let logoView = LogoView()
    private let amountView = ResultView()
    private let billInputView = InputView()
    private let tipView = TipView()
    private let splitView = SplitView()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            logoView,
            amountView,
            billInputView,
            tipView,
            splitView,
            UIView()
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 36
        
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

}

// MARK: - CODEVIEW
extension CalculatorViewController: CodeView {
    func buildHierarchy() {
        view.addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-16)
            make.top.equalTo(view.snp.topMargin).offset(16)
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        amountView.snp.makeConstraints { make in
            make.height.equalTo(224)
        }
        
        billInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        tipView.snp.makeConstraints { make in
            make.height.equalTo(56 + 56 + 16)
        }
        
        splitView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = ThemeColor.background
    }
}

