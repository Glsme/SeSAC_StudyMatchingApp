//
//  SearchData.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/17.
//

import Foundation

struct SearchData: Codable {
    let fromQueueDB: [String]
    let fromQueueDBRequested: [String]
    let fromRecommend: [String]
    
    init(fromQueueDB: [String], fromQueueDBRequested: [String], fromRecommend: [String]) {
        self.fromQueueDB = fromQueueDB
        self.fromQueueDBRequested = fromQueueDBRequested
        self.fromRecommend = fromRecommend
    }
}
