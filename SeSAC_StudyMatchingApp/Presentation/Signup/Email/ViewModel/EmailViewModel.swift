//
//  EmailViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import Foundation

import RxCocoa

class EmailViewModel: CommonViewModel {
    struct Input {
        let emailText: ControlProperty<String?>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let emailText: ControlEvent<String>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let email = input.emailText
            .orEmpty
            .changed
        
        let nextButtonTapped = input.nextButtonTapped
        return Output(emailText: email, nextButtonTapped: nextButtonTapped)
    }
    
    public func vaildEmail(_ email: String) -> Bool {
        let regex = RegexValidation.email.rawValue
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
}
