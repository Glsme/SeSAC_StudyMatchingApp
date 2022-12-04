//
//  SearchTabViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/21.
//

import Foundation

final class SearchTabViewModel: CommonViewModel {
    var searchData: SearchData?
    var lat: Double = 0
    var long: Double = 0
    
    func requsetSearchData(lat: Double, long: Double, completion: @escaping (Result<SearchData, Error>) -> Void) {
        let api = SesacAPIQueueRouter.searchPost(lat: String(lat), long: String(long))
        SesacSignupAPIService.shared.requestSesacSearch(router: api) { response in
            switch response {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                print("Error", error)
                completion(.failure(error))
            }
        }
    }
    
    func requestMyQueueState(completion: @escaping (MyQueueState) -> Void) {
        let api = SesacAPIRouter.myQueueStateGet
        SesacSignupAPIService.shared.requestMyStateData(router: api) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let success):
                if success.matched == 1 {
                    completion(success)
                }
            case .failure(let failure):
                print(failure)
                
                switch failure {
                case .firebaseError:
                    self.refreshToken {
                        SesacSignupAPIService.shared.requestMyStateData(router: api) { response in
                            switch response {
                            case .success(let success):
                                if success.matched == 1 {
                                    completion(success)
                                }
                            case .failure(let failure):
                                print(failure)
                            }
                        }
                    }
                default:
                    break
                }
            }
        }
    }
    
    func requestStopMatching(completion: @escaping (Int) -> Void) {
        let api = SesacAPIRouter.myQueueStateDelete
        SesacSignupAPIService.shared.requestSesacSearchSesacData(router: api) { statusCode in
            completion(statusCode)
        }
    }
}

enum stopMatchingCode: Int {
    case success = 200
    case alreadyStop = 201
    case firebaseTokenError = 401
    case noSignup = 406
    case serverError = 500
    case clientError = 501
}
