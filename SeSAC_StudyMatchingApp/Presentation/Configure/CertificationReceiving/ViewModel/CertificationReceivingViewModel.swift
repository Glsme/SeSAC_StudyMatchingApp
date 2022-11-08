//
//  CertificationReceivingViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/08.
//

import Foundation

import RxSwift

final class CertificationReceivingViewModel {
    let authVerificationID = PublishSubject<String>()
    
    public func setAuthVerificationID() {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
        
        authVerificationID.onNext(verificationID)
    }
}
