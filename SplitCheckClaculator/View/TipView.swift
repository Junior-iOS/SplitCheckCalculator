//
//  TipView.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 07/01/23.
//

import Foundation
import UIKit
import Combine

final class TipView: UIView {
    
    private var cancellables = Set<AnyCancellable>()
    
    private let descriptionView: DescriptionView = {
        let view = DescriptionView(top: "Choose", bottom: "your tip")
        return view
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = buildTipButton(with: .tenPercent)
        button.tapPublisher.flatMap({
            Just(Tip.tenPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = buildTipButton(with: .fifteenPercent)
        button.tapPublisher.flatMap({
            Just(Tip.fifteenPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(with: .twentyPercent)
        button.tapPublisher.flatMap({
            Just(Tip.twentyPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom Tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(8)
        button.tapPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            self.handleTipButton()
        }.store(in: &cancellables)
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
        return stack
    }()
    
    private let tipSubject: CurrentValueSubject<Tip, Never> = .init(.none)
    
    var tipPublisher: AnyPublisher<Tip, Never> {
        tipSubject.eraseToAnyPublisher()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        observe()
    }
    
    private func resetView() {
        [tenPercentTipButton,
         fifteenPercentTipButton,
         twentyPercentTipButton,
         customTipButton].forEach({
            $0.backgroundColor = ThemeColor.primary
        })
        
        let text = NSMutableAttributedString(
            string: "Custom tip",
            attributes: [
                .font: ThemeFont.bold(ofSize: 20)
            ])
        customTipButton.setAttributedTitle(text, for: .normal)
    }
    
    private func observe() {
        tipSubject.sink { [unowned self] tip in
            resetView()
            switch tip {
            case .none:
                break
            case .tenPercent:
                tenPercentTipButton.backgroundColor = ThemeColor.secondary
            case .fifteenPercent:
                fifteenPercentTipButton.backgroundColor = ThemeColor.secondary
            case .twentyPercent:
                twentyPercentTipButton.backgroundColor = ThemeColor.secondary
            case .custom(let value):
                customTipButton.backgroundColor = ThemeColor.secondary
                
                let text = NSMutableAttributedString(
                    string: "R$\(value)",
                    attributes: [
                        .font: ThemeFont.bold(ofSize: 20)
                    ])
                text.addAttributes([
                    .font: ThemeFont.bold(ofSize: 14)
                ], range: NSRange(location: 0, length: 2))
                customTipButton.setAttributedTitle(text, for: .normal)
            }
        }.store(in: &cancellables)
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
    
    private func handleTipButton() {
        let alertController: UIAlertController = {
            let alert = UIAlertController(title: "Enter custom tip", message: nil, preferredStyle: .alert)
            alert.addTextField{ textField in
                textField.placeholder = "Make it geneours!"
                textField.keyboardType = .decimalPad
                textField.autocorrectionType = .no
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            let ok = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
                guard let text = alert.textFields?.first?.text, let value = Int(text) else { return }
                self?.tipSubject.send(.custom(value: value))
            }
            [cancel, ok].forEach( alert.addAction(_:) )
            return alert
        }()
        
        parentViewController?.present(alertController, animated: true)
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
