//
//  MockAudioPlayerService.swift
//  SplitCheckClaculatorTests
//
//  Created by Junior Silva on 24/01/23.
//

import Foundation
import XCTest
import Combine
@testable import SplitCheckClaculator

class MockAudioPLayerService: AudioPlayerService {
    let expectation = XCTestExpectation(description: "Playsound was called")
    
    func playSound() {
        expectation.fulfill()
    }
}
