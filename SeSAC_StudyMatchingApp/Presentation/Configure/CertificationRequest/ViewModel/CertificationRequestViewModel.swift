//
//  CertificationViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import Foundation

import FirebaseCore
import FirebaseAuth

final class CertificationRequestViewModel {
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
    
    
    public func requsetPhoneAuth(_ phoneNumber: String) {
        let phoneNum = changePhoneNumberFomat(phoneNumber)
        
        PhoneAuthProvider.provider()
          .verifyPhoneNumber(phoneNum, uiDelegate: nil) { verificationID, error in
              if let error = error {
                  print("!!!!error \(error)")
                return
              }
              
              UserManager.authVerificationID = verificationID
          }
    }
    
    private func changePhoneNumberFomat(_ phoneNumber: String) -> String {
        let phoneNum = Array(phoneNumber).dropFirst()
        return "+82" + " " + String(phoneNum)
    }
}
