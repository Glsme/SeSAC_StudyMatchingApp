//
//  SplashViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/11.
//

import Foundation

final class SplashViewModel {
    func loginSesacServer(completion: @escaping (Result<UserData, LoginError>) -> Void) {
        let api = SesacAPIRouter.loginGet
        SesacSignupAPIService.shared.requsetSesacLogin(router: api) { response in
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
