//
//  MyState.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/20.
//

import Foundation

// MARK: - MyQueueState
struct MyQueueState: Codable {
    let dodged, matched, reviewed: Int
    let matchedNick, matchedUid: String?
}
