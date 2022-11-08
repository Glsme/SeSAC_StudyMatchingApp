//
//  CertificationReceivingViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/08.
//

import Foundation

import FirebaseAuth
import FirebaseCore
import RxSwift

final class CertificationReceivingViewModel {    
    public func setAuthVerificationID(_ verificationCode: String) -> Bool {
        var valid = false
        
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return false }
        
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("error \(error)")
            } else {
                valid = true
            }
        }
        
        return valid
    }
}
