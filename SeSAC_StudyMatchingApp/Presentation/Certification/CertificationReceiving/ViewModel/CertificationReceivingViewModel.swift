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
        let retryButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let certificationText: ControlProperty<String>
        let requsetButtonTapped: ControlEvent<Void>
        let retryButtonTapped: ControlEvent<Void>
    }
    
    public func transform(input: Input) -> Output {
        let certificationText = input.certificationText
            .orEmpty
        
        let requsetButtonTapped = input.requstButtonTapped
        let retryButtonTapped = input.retryButtonTapped
        
        return Output(certificationText: certificationText, requsetButtonTapped: requsetButtonTapped, retryButtonTapped: retryButtonTapped)
    }
    
    public func signInWithVerfiyCode(_ verficationCode: String, completion: @escaping (String) -> Void) {
        guard let verificationID = UserManager.authVerificationID else { return }
        
        FirebaseAPIService.shared.requsetSignIn(verificationID: verificationID, verificationCode: verficationCode) { response in
            switch response {
            case .success(let result):
                result.user.getIDToken { token, error in
                    if let token = token {
                        UserManager.authVerificationToken = token
                        completion(token)
                    } else {
                        print("Token Error")
                    }
                }
            case .failure(let error):
                guard let error = error.errorDescription else { return }
                completion(error)
            }
        }
    }
    
    public func requsetPhoneAuth(completion: @escaping (String) -> Void) {
        var valid = ""
        guard let phoneNum = UserManager.phoneNumber else { return }
        
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
    
    public func requsetLogin() {
        let router = SesacAPIRouter.loginGet
        SesacSignupAPIService.shared.requsetSesacLogin(router: router) { response in
            switch response {
            case .success(let success):
                print(success)
            case .failure(let failure):
                guard let loginError = failure as? LoginError else { return }
                if loginError.rawValue == 406 {
                    print("미가입 유저!!!!!!!!!!")
                }
            }
        }
    }
}