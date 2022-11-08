//
//  CertificationReceivingViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/08.
//

import Foundation

import RxCocoa

class CertificationReceivingViewModel: CommonViewModel {
    struct Input {
        let certificationText: ControlProperty<String?>
        let requstButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let certificationText: ControlProperty<String>
        let requsetButtonTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let certificationText = input.certificationText
            .orEmpty
        
        let requsetButtonTapped = input.requstButtonTapped
        
        return Output(certificationText: certificationText, requsetButtonTapped: requsetButtonTapped)
    }
}
