//
//  CertificationReceivingViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/08.
//

import Foundation

final class CertificationReceivingViewModel {
    let authVerificationID: String = ""
    
    public func setAuthVerificationID() {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
            return
        }
    }
}
