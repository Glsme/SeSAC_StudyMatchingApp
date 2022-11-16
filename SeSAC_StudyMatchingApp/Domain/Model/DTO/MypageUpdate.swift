//
//  MypageUpdate.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/16.
//

import Foundation

struct MypageUpdate {
    let searchable: Int
    let ageMin: Int
    let ageMax: Int
    let gender: Int
    let study: String
    
    init(searchable: Int, ageMin: Int, ageMax: Int, gender: Int, study: String) {
        self.searchable = searchable
        self.ageMin = ageMin
        self.ageMax = ageMax
        self.gender = gender
        self.study = study
    }
}
