//
//  SplitView.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 07/01/23.
//

import Foundation
import UIKit

final class SplitView: UIView {
    
    private let descriptionView: DescriptionView = {
        let view = DescriptionView(top: "Split", bottom: "the total")
        return view
    }()
    
    private lazy var decrementButton: UIButton = {
        return buildButton(text: "-", corner: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
    }()
    
    private lazy var increaseButton: UIButton = {
        return buildButton(text: "+", corner: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
    }()
    
    private let quantityLabel: UILabel = {
        return LabelFactory.build(text: "1", font: ThemeFont.bold(ofSize: 20), backgroundColor: .white)
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [decrementButton, quantityLabel, increaseButton])
        stack.axis = .horizontal
        stack.spacing = 0
        stack.addShadow(offset: CGSize(width: 0, height: 3), color: .black, radius: 12.0, opacity: 0.1)
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildButton(text: String, corner: CACornerMask) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.addRoundedCorners(corner, radius: 8.0)
        button.backgroundColor = ThemeColor.primary
        return button
    }
}

extension SplitView: CodeView {
    func buildHierarchy() {
        addSubviews(descriptionView, stackView)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        [decrementButton, increaseButton].forEach { button in
            button.snp.makeConstraints { make in
                make.width.equalTo(button.snp.height)
            }
        }
        
        descriptionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(stackView.snp.centerY)
            make.trailing.equalTo(stackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }
    }
    
    func setupAdditionalConfiguration() {}
}
