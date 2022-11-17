//
//  SearchData.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/17.
//

import Foundation

// MARK: - SearchData
struct SearchData: Codable {
    let fromQueueDB: [FromQueueDB]
    let fromQueueDBRequested: [FromQueueDBRequested]
    let fromRecommend: [String]
    
    init(fromQueueDB: [FromQueueDB], fromQueueDBRequested: [FromQueueDBRequested], fromRecommend: [String]) {
        self.fromQueueDB = fromQueueDB
        self.fromQueueDBRequested = fromQueueDBRequested
        self.fromRecommend = fromRecommend
    }
}

// MARK: - FromQueueDB
struct FromQueueDB: Codable {
    let studylist, reviews: [String]
    let reputation: [Int]
    let uid, nick: String
    let gender, type, sesac, background: Int
    let long, lat: Double
    
    init(studylist: [String], reviews: [String], reputation: [Int], uid: String, nick: String, gender: Int, type: Int, sesac: Int, background: Int, long: Double, lat: Double) {
        self.studylist = studylist
        self.reviews = reviews
        self.reputation = reputation
        self.uid = uid
        self.nick = nick
        self.gender = gender
        self.type = type
        self.sesac = sesac
        self.background = background
        self.long = long
        self.lat = lat
    }
}

// MARK: - FromQueueDBReQuested
struct FromQueueDBRequested: Codable {
    let studylist, reviews: [String]
    let reputation: [Int]
    let uid, nick: String
    let gender, type, sesac, background: Int
    let long, lat: Double
    
    init(studylist: [String], reviews: [String], reputation: [Int], uid: String, nick: String, gender: Int, type: Int, sesac: Int, background: Int, long: Double, lat: Double) {
        self.studylist = studylist
        self.reviews = reviews
        self.reputation = reputation
        self.uid = uid
        self.nick = nick
        self.gender = gender
        self.type = type
        self.sesac = sesac
        self.background = background
        self.long = long
        self.lat = lat
    }
}
