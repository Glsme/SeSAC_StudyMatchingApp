//
//  MyChat.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/25.
//

import Foundation

// MARK: - MyChat
struct MyChat: Codable {
    let payload: [Payload]
}

// MARK: - Payload
struct Payload: Codable {
    let id, to, from, chat: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case to, from, chat, createdAt
    }
}
