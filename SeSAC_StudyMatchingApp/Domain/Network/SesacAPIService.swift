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
    
    public func requestFCMTokenUpdate(router: SesacAPIUserRouter, completion: @escaping (Int) -> Void) {
        AF.request(router).responseString { response in
            guard let statusCode = response.response?.statusCode else { return }
            completion(statusCode)
        }
    }
    
    public func requestSesacLogin(router: SesacAPIUserRouter, completionHandler: @escaping(Result<UserData, Error>) -> Void) {
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
    
    public func requestSesacUpdate(router: SesacAPIUserRouter, completionHandler: @escaping(Result<String, Error>) -> Void) {
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
    
    public func requestSesacSearch(router: SesacAPIQueueRouter, completionHandler: @escaping (Result<SearchData, Error>) -> Void) {
        AF.request(router).responseDecodable(of: SearchData.self) { response in
            switch response.result {
            case .success(let success):
//                dump(success)
                completionHandler(.success(success))
            case .failure(_):
                guard let statusCode = response.response?.statusCode else { return }
                guard let error = LoginError(rawValue: statusCode) else { return }
                completionHandler(.failure(error))
                
            }
        }
    }
    
    public func requestSesacSearchSesacData(router: SesacAPIRouter, completionHandler: @escaping (Int) -> Void) {
        AF.request(router).responseDecodable(of: Int.self) { response in
            print(response.result)
            guard let statusCode = response.response?.statusCode else { return }
            completionHandler(statusCode)
        }
    }
    
    public func requestMyStateData(router: SesacAPIRouter, completionHandler: @escaping (Result<MyQueueState, MyQueueStateResponse>) -> Void) {
        AF.request(router).responseDecodable(of: MyQueueState.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(_):
                guard let statusCode = response.response?.statusCode else { return }
                guard let error = MyQueueStateResponse(rawValue: statusCode) else { return }
                completionHandler(.failure(error))
            }
        }
    }
    
    public func requestStudyRequest(router: SesacAPIRouter, completionHandler: @escaping (Int) -> Void) {
        AF.request(router).responseString { response in
            dump(response.result)
            guard let statusCode = response.response?.statusCode else { return }
            completionHandler(statusCode)
        }
    }
    
    public func requestPostChat(router: SesacAPIRouter, completionHandler: @escaping (Int) -> Void) {
        AF.request(router).responseString { response in
            guard let statusCode = response.response?.statusCode else { return }
            completionHandler(statusCode)
        }
    }
    
    public func requestGetChat(router: SesacAPIRouter, completionHandler: @escaping (Result<MyChat, LoginError>) -> Void) {
        AF.request(router).responseDecodable(of: MyChat.self) { response in
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
    
    public func requestShopInfo(router: SesacAPIUserRouter, completion: @escaping (Result<ShopInfo, LoginError>) -> Void) {
        AF.request(router).responseDecodable(of: ShopInfo.self) { response in
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(_):
                guard let statusCode = response.response?.statusCode else { return }
                guard let error = LoginError(rawValue: statusCode) else { return }
                completion(.failure(error))
            }
        }
    }
}
