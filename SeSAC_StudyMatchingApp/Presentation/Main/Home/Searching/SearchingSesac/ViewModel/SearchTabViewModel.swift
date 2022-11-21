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
}
