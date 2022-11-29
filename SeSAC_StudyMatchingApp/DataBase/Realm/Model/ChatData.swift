//
//  ChatData.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/29.
//

import UIKit
import RealmSwift

class ChatData: Object {
    private override init() { }
    
    @Persisted var uid: String
    @Persisted var chatList: List<ChatListData>
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(uid: String, chatList: List<ChatListData>) {
        self.init()
        self.uid = uid
        self.chatList = chatList
    }
}

class ChatListData: Object {
    @Persisted var id: String
    @Persisted var to: String
    @Persisted var from: String
    @Persisted var chat: String
    @Persisted var createdAt: String
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(id: String, to: String, from: String, chat: String, createdAt: String) {
        self.init()
        self.id = id
        self.to = to
        self.from = from
        self.chat = chat
        self.createdAt = createdAt
    }
}
