//
//  EmailViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import Foundation

class EmailViewModel: CommonViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    public func vaildEmail(_ email: String) -> Bool {
        let regex = RegexValidation.email.rawValue
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
}
