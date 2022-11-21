//
//  SearchTabViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/21.
//

import Foundation

class SearchTabViewModel {
    var searchData: SearchData?
    
    func requsetSearchData(lat: Double, long: Double, completion: @escaping (Result<SearchData, Error>) -> Void) {
        let api = SesacAPIRouter.searchPost(lat: String(lat), long: String(long))
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
