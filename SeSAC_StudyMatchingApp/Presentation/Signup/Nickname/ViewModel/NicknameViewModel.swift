//
//  NicknameViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import Foundation

import RxCocoa

final class NicknameViewModel: CommonViewModel {
    struct Input {
        let nicknameText: ControlProperty<String?>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let nicknameText: ControlEvent<String>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let nicknameText = input.nicknameText
            .orEmpty
            .changed
        
        let nextButtonTapped = input.nextButtonTapped
        
        return Output(nicknameText: nicknameText, nextButtonTapped: nextButtonTapped)
    }
}
