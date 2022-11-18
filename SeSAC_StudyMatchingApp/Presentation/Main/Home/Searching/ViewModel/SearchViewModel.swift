//
//  SearchViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/16.
//

import UIKit

struct StudyTag: Hashable {
    let uuid = UUID().uuidString
    let title: String
}

class SearchViewModel {
    let titleArray: [String] = ["지금 주변에는", "내가 하고 싶은"]
    var myHopeStudies: [StudyTag] = []
    var recommandData: [StudyTag] = []
    var fromQueueDB: [StudyTag] = []
    var lat: Double = 0
    var long: Double = 0
    
    
    func checkOverlappingStudyName(_ text: String) -> Bool {
        return myHopeStudies.filter { $0.title == text }.count > 0 ? false : true
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
    
    func requsetSearchSesac(completion: @escaping (Int) -> Void) {
        let studylist = myHopeStudies.count == 0 ? ["Anything"] : myHopeStudies.map { $0.title }
        let data: SearchSesacData = SearchSesacData(lat: lat, long: long, studylist: studylist)
        print(data)
        let api = SesacAPIRouter.searchSesacPost(data: data)
        SesacSignupAPIService.shared.requestSesacSearchSesacData(router: api) { statusCode in
            print(statusCode)
            completion(statusCode)
        }
    }
}
