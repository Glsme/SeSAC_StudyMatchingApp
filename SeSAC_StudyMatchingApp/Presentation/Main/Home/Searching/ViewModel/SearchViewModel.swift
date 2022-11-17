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
    
    func checkOverlappingStudyName(_ text: String) -> Bool {
        return myHopeStudies.filter { $0 == text }.count > 0 ? false : true
    }
}
