//
//  GenderViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import Foundation

import RxCocoa

class GenderViewModel: CommonViewModel {
    struct Input {
        let womanButtonTapped: ControlEvent<Void>
        let manButtonTapped: ControlEvent<Void>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let womanButtonTapped: ControlEvent<Void>
        let manButtonTapped: ControlEvent<Void>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let womanButon = input.womanButtonTapped
        let manButton = input.manButtonTapped
        let nextButton = input.nextButtonTapped
        
        return Output(womanButtonTapped: womanButon, manButtonTapped: manButton, nextButtonTapped: nextButton)
    }
}
