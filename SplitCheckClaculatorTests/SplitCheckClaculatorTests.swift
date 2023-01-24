//
//  SplitCheckClaculatorTests.swift
//  SplitCheckClaculatorTests
//
//  Created by Junior Silva on 07/01/23.
//

import XCTest
import Combine
@testable import SplitCheckClaculator

final class SplitCheckClaculatorTests: XCTestCase {
    
    private var sut: CalculatorViewModel!
    private var cancellable: Set<AnyCancellable>!
    private var logoViewSubject: PassthroughSubject<Void, Never>!
    private var mockAudioPlayer: MockAudioPLayerService!

    override func setUp() {
        mockAudioPlayer = .init()
        sut = .init(audioPlayerService: mockAudioPlayer)
        cancellable = .init()
        logoViewSubject = .init()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        mockAudioPlayer = nil
        sut = nil
        cancellable = nil
        logoViewSubject = nil
    }
    
    func testResultWithouTipForOnePerson() {
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 1
        
        let output = sut.transform(input: buildInput(bill: bill, tip: tip, split: split))
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 100)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellable)
    }
    
    func testResultWithouTipForTwoPeople() {
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 2
        
        let output = sut.transform(input: buildInput(bill: bill, tip: tip, split: split))
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 50)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellable)
    }
    
    func testResultWith10PercentTipForTwoPeople() {
        let bill: Double = 100.0
        let tip: Tip = .tenPercent
        let split: Int = 2
        
        let output = sut.transform(input: buildInput(bill: bill, tip: tip, split: split))
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 55)
            XCTAssertEqual(result.totalBill, 110)
            XCTAssertEqual(result.totalTip, 10)
        }.store(in: &cancellable)
    }
    
    func testResultWith15PercentTipForThreePeople() {
        let bill: Double = 300
        let tip: Tip = .fifteenPercent
        let split: Int = 3
        
        let output = sut.transform(input: buildInput(bill: bill, tip: tip, split: split))
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 115)
            XCTAssertEqual(result.totalBill, 345)
            XCTAssertEqual(result.totalTip, 45)
        }.store(in: &cancellable)
    }
    
    func testResultWith20PercentTipForFourPeople() {
        let bill: Double = 300.0
        let tip: Tip = .twentyPercent
        let split: Int = 4
        
        let output = sut.transform(input: buildInput(bill: bill, tip: tip, split: split))
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 90)
            XCTAssertEqual(result.totalBill, 360)
            XCTAssertEqual(result.totalTip, 60)
        }.store(in: &cancellable)
    }
    
    func testResultWithCustomTipForFivePeople() {
        let bill: Double = 250
        let tip: Tip = .custom(value: 100)
        let split: Int = 5
        
        let output = sut.transform(input: buildInput(bill: bill, tip: tip, split: split))
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 70)
            XCTAssertEqual(result.totalBill, 350)
            XCTAssertEqual(result.totalTip, 100)
        }.store(in: &cancellable)
    }
    
    func testSoundPlayerAndCalculatorResetOnLogoView() {
        let input = buildInput(bill: 100, tip: .tenPercent, split: 2)
        let output = sut.transform(input: input)
        let resetExpectation = XCTestExpectation(description: "Reset calculator called")
        let audioExpectation = mockAudioPlayer.expectation
        
        output.resetCalculatorPublisher.sink { _ in
            resetExpectation.fulfill()
        }.store(in: &cancellable)
        
        logoViewSubject.send()
        wait(for: [resetExpectation, audioExpectation], timeout: 1)
    }
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorViewModel.Input {
        return .init(billPublisher: Just(bill).eraseToAnyPublisher(),
                     tipPublisher: Just(tip).eraseToAnyPublisher(),
                     splitPublisher: Just(split).eraseToAnyPublisher(),
                     logoViewTapPublisher: logoViewSubject.eraseToAnyPublisher())
    }

}
