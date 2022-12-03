//
//  SplashViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/11.
//

import Foundation

import FirebaseAuth

final class SplashViewModel {
    func loginSesacServer(completion: @escaping (Result<UserData, LoginError>) -> Void) {
        let api = SesacAPIUserRouter.loginGet
        SesacSignupAPIService.shared.requestSesacLogin(router: api) { response in
            switch response {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                guard let error = error as? LoginError else { return }
                completion(.failure(error))
            }
        }
    }
    
    func refreshAndRetryLogin(completion: @escaping (Result<UserData, LoginError>) -> Void) {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                print("Refresh Error:: \(error)")
                return;
            }
            
            UserManager.authVerificationToken = idToken
            let api = SesacAPIUserRouter.loginGet
            
            SesacSignupAPIService.shared.requestSesacLogin(router: api) { response in
                switch response {
                case .success(let success):
                    completion(.success(success))
                case .failure(let error):
                    guard let error = error as? LoginError else { return }
                    completion(.failure(error))
                }
            }
        }
    }
}
