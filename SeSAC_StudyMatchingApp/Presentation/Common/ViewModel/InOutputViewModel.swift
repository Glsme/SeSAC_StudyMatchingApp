//
//  CommonViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/09.
//

import Foundation

import FirebaseAuth

protocol InOutputViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class CommonViewModel {
    func refreshToken() {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                print("Refresh Error:: \(error)")
                return;
            }
            
            UserManager.authVerificationToken = idToken
            let api = SesacAPIRouter.loginGet
        }
    }
}
