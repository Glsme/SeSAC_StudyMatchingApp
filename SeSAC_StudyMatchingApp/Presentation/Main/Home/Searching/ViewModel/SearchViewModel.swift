//
//  SearchViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/16.
//

import UIKit

class SearchViewModel {
    var tagTitle: [String] = ["hi", "dfasdf", "Adsfsdfds", "ADfdsfasfasf"]
    let titleArray: [String] = ["지금 주변에는", "내가 하고 싶은"]
    var myHopeStudies: [String] = []
    var recommandData: [String] = []
    
    func checkOverlappingStudyName(_ text: String) -> Bool {
        return myHopeStudies.filter { $0 == text }.count > 0 ? false : true
    }
    
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
