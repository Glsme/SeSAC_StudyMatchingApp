//
//  WithdarwViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/16.
//

import Foundation

class WithdrawViewModel {
    func requsetWithdarw(completion: @escaping (Result<String, LoginError>) -> Void) {
        let api = SesacAPIRouter.withdraw
        SesacSignupAPIService.shared.requsetSesacUpdate(router: api) { response in
            switch response {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                guard let error = error as? LoginError else { return }
                print(error.rawValue)
                completion(.failure(error))
            }
        }
    }
    
    func removeAllUserDefaultsData() {
        UserDefaults.standard.removeObject(forKey: "fcmToken")
        UserDefaults.standard.removeObject(forKey: "authVerificationID")
        UserDefaults.standard.removeObject(forKey: "first")
        UserDefaults.standard.removeObject(forKey: "phoneNumber")
        UserDefaults.standard.removeObject(forKey: "authVerificationToken")
        UserDefaults.standard.removeObject(forKey: "certificationCode")
        UserDefaults.standard.removeObject(forKey: "nickname")
        UserDefaults.standard.removeObject(forKey: "birth")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "gender")
        UserDefaults.standard.removeObject(forKey: "sesac")
    }
}
