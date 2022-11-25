//
//  GenderViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import Foundation

import FirebaseAuth
import FirebaseMessaging
import RxCocoa

class GenderViewModel: InOutputViewModel {
    struct Input {
        let womanButtonTapped: ControlEvent<Void>
        let manButtonTapped: ControlEvent<Void>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let womanButtonTapped: ControlEvent<Void>
        let manButtonTapped: ControlEvent<Void>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let womanButon = input.womanButtonTapped
        let manButton = input.manButtonTapped
        let nextButton = input.nextButtonTapped
        
        return Output(womanButtonTapped: womanButon, manButtonTapped: manButton, nextButtonTapped: nextButton)
    }
    
    func requsetSignup(completion: @escaping (Result<UserData, LoginError>) -> Void) {
        Messaging.messaging().token { token, error in
            if let error = error {
//                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
//                print("FCM registration token: \(token)")
                UserManager.fcmToken = token
            }
        }
        
        let api = SesacAPIRouter.signupPost
        SesacSignupAPIService.shared.requestSesacLogin(router: api) { response in
            switch response {
            case .success(let success):
                print(success)
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
            let api = SesacAPIRouter.signupPost
            
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
