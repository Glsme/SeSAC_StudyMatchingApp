//
//  CertificationViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import Foundation

import FirebaseCore
import FirebaseAuth
import RxCocoa

final class CertificationRequestViewModel: CommonViewModel {
    struct Input {
        let certificationText: ControlProperty<String?>
        let requstButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let certificationText: ControlEvent<String>
        let requsetButtonTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let certificationText = input.certificationText
            .orEmpty
            .changed
        
        let requsetButtonTapped = input.requstButtonTapped
        
        return Output(certificationText: certificationText, requsetButtonTapped: requsetButtonTapped)
    }
    
    public func changePhoneNumformat(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    public func vaildPhoneNumber(_ phoneNumber: String) -> Bool {
        let regex = RegexValidation.phoneNumber.rawValue
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phoneNumber)
    }
    
    public func requsetPhoneAuth(_ phoneNumber: String, completion: @escaping (String) -> Void) {
        let phoneNum = changePhoneNumberFomat(phoneNumber)
        UserManager.phoneNumber = phoneNum
        var valid = CertificationRequestMents.validFormat.rawValue
        
        FirebaseAPIService.shared.requsetPhoneAuth(phoneNum) { response in
            switch response {
            case .success(let success):
                UserManager.authVerificationID = success
                completion(valid)
            case .failure(let failure):
                valid = failure.errorDescription!
                completion(valid)
            }
        }
    }
    
    private func changePhoneNumberFomat(_ phoneNumber: String) -> String {
        let phoneNum = Array(phoneNumber).dropFirst()
        return "+82" + " " + String(phoneNum)
    }
}
