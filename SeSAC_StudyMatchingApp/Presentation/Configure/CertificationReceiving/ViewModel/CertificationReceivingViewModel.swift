//
//  CertificationReceivingViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/08.
//

import Foundation

import RxCocoa

final class CertificationReceivingViewModel: CommonViewModel {
    struct Input {
        let certificationText: ControlProperty<String?>
        let requstButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let certificationText: ControlProperty<String>
        let requsetButtonTapped: ControlEvent<Void>
    }
    
    public func transform(input: Input) -> Output {
        let certificationText = input.certificationText
            .orEmpty
        
        let requsetButtonTapped = input.requstButtonTapped
        
        return Output(certificationText: certificationText, requsetButtonTapped: requsetButtonTapped)
    }
    
    public func signInWithVerfiyCode(_ verficationCode: String, completion: @escaping (String) -> Void) {
        guard let verificationID = UserManager.authVerificationID else { return }

        FirebaseAPIService.shared.requsetSignIn(verificationID: verificationID, verificationCode: verficationCode) { response in
            switch response {
            case .success(let result):
                completion(result.description)
            case .failure(let error):
                guard let error = error.errorDescription else { return }
                completion(error)
            }
        }
    }
}
