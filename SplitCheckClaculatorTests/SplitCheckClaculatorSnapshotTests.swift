//
//  SplitCheckClaculatorSnapshotTests.swift
//  SplitCheckClaculatorTests
//
//  Created by Junior Silva on 24/01/23.
//

import XCTest
import SnapshotTesting
@testable import SplitCheckClaculator

final class SplitCheckClaculatorSnapshotTests: XCTestCase {
    
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func testLogoView() {
        let size = CGSize(width: screenWidth, height: 48)
        let view = LogoView()
        
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testResultView() {
        let size = CGSize(width: screenWidth, height: 224)
        let view = ResultView()
        
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testResultViewWithValues() {
        let size = CGSize(width: screenWidth, height: 224)
        let view = ResultView()
        view.configure(result: Result(amountPerPerson: 110, totalBill: 100, totalTip: 10))
        
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInputView() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = BillInputView()
        
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInputViewWithValues() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = BillInputView()
        let textField = view.allSubViewsOf(type: UITextField.self).first
        textField?.text = "500"
        
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testTipView() {
        let size = CGSize(width: screenWidth, height: 56 + 56 + 16)
        let view = TipView()
        
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testTipViewWithSelection() {
        let size = CGSize(width: screenWidth, height: 56 + 56 + 16)
        let view = TipView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testSplitView() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = SplitView()
        
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testSplitViewWithSelection() {
        let size = CGSize(width: screenWidth, height: 56)
        let view = SplitView()
        let button = view.allSubViewsOf(type: UIButton.self).last
        button?.sendActions(for: .touchUpInside)
        
        assertSnapshot(matching: view, as: .image(size: size))
    }

}

extension UIView {
//    https://stackoverflow.com/a/45297466/6181721
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}
