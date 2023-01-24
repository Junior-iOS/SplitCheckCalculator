//
//  CalculatorViewController.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 07/01/23.
//

import UIKit
import SnapKit
import Combine

class CalculatorViewController: UIViewController {
    
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = InputView()
    private let tipView = TipView()
    private let splitView = SplitView()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
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
    
    private lazy var viewTapPublisher: AnyPublisher<Bool, Never> = {
        let tap = UITapGestureRecognizer(target: self, action: nil)
        view.addGestureRecognizer(tap)
        return tap.tapPublisher.flatMap { _ in
            Just(true)
        }.eraseToAnyPublisher()
    }()
    
    private lazy var logoViewTapPublisher: AnyPublisher<Void, Never> = {
        let tap = UITapGestureRecognizer(target: self, action: nil)
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        return tap.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    private let viewModel = CalculatorViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func bind() {
        let input = CalculatorViewModel.Input(billPublisher: billInputView.billPublisher,
                                              tipPublisher: tipView.tipPublisher,
                                              splitPublisher: splitView.splitPublisher,
                                              logoViewTapPublisher: logoViewTapPublisher)
        let output = viewModel.transform(input: input)
        output.updateViewPublisher.sink { [unowned self] result in
            resultView.configure(result: result)
        }.store(in: &cancellables)
    }

    private func observe() {
        viewTapPublisher.sink { [unowned self] value in
            self.view.endEditing(value)
        }.store(in: &cancellables)
        
        logoViewTapPublisher.sink { _ in
            print("TAPPED LOGO")
        }.store(in: &cancellables)
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
        
        resultView.snp.makeConstraints { make in
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
        bind()
        observe()
    }
}

