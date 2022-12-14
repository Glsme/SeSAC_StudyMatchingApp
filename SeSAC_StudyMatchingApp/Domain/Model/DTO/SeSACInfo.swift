//
//  UserInfo.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/16.
//

import Foundation

struct SeSACInfo {
    let background: Int
    let sesac: Int
    let nick: String
    let reputation: [Int]
    let comment: [String]
    let gender: Int
    let study: String
    let searchable: Int
    let ageMin: Int
    let ageMax: Int
    let uid: String
    
    init(background: Int = 0,
         sesac: Int = 0,
         nick: String = "",
         reputation: [Int] = [],
         comment: [String] = [],
         gender: Int = 0,
         study: String = "",
         searchable: Int = 0,
         ageMin: Int = 0,
         ageMax: Int = 0,
         uid: String = ""){
        self.background = background
        self.sesac = sesac
        self.nick = nick
        self.reputation = reputation
        self.comment = comment
        self.gender = gender
        self.study = study
        self.searchable = searchable
        self.ageMin = ageMin
        self.ageMax = ageMax
        self.uid = uid
    }
}
