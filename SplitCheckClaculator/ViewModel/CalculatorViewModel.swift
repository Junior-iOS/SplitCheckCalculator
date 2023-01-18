//
//  CalculatorViewModel.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 17/01/23.
//

import Foundation
import Combine

final class CalculatorViewModel {
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
    }
    
    func transform(input: Input) -> Output {
        let result = Result(totalBill: 150, amountPerPerson: 50, totalTip: 15)
        return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
    }
    
}
