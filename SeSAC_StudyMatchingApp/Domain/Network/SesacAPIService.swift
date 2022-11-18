//
//  SesacAPIService.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import Foundation
import Alamofire

final class SesacSignupAPIService {
    static let shared = SesacSignupAPIService()
    
    private init() { }
    
    public func requsetSesacLogin(router: SesacAPIRouter, completionHandler: @escaping(Result<UserData, Error>) -> Void) {
        AF.request(router).responseDecodable(of: UserData.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(_):
                guard let statusCode = response.response?.statusCode else { return }
                guard let error = LoginError(rawValue: statusCode) else { return }
                completionHandler(.failure(error))
                
            }
        }
    }
    
    public func requsetSesacUpdate(router: SesacAPIRouter, completionHandler: @escaping(Result<String, Error>) -> Void) {
        AF.request(router).responseDecodable(of: String.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(_):
                guard let statusCode = response.response?.statusCode else { return }
                guard let error = LoginError(rawValue: statusCode) else {
                    if statusCode == 200 {
                        completionHandler(.success("success"))
                    }
                    return
                }
                completionHandler(.failure(error))
                
            }
        }
    }
    
    public func requestSesacSearch(router: SesacAPIRouter, completionHandler: @escaping (Result<SearchData, Error>) -> Void) {
        AF.request(router).responseDecodable(of: SearchData.self) { response in
            switch response.result {
            case .success(let success):
                dump(success)
                completionHandler(.success(success))
            case .failure(_):
                guard let statusCode = response.response?.statusCode else { return }
                guard let error = LoginError(rawValue: statusCode) else { return }
                completionHandler(.failure(error))
                
            }
        }
    }
}
