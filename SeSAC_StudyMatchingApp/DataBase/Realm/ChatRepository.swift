//
//  ChatRepository.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/29.
//

import Foundation
import RealmSwift

class ChatRepository {
    static let shared = ChatRepository()
    
    private init() { }
    
    let localRealm = try! Realm()
    
    var primaryKey: ObjectId?
    
    func write(_ task: ChatData) {
        try! localRealm.write {
            localRealm.add(task)
        }
    }
    
    func chatWrite(_ task: Payload, chatData: ChatData) {
        let data: ChatListData = ChatListData(id: task.id, to: task.to, from: task.from, chat: task.chat, createdAt: task.createdAt)
        try! localRealm.write {
            chatData.chatList.append(data)
        }
    }
    
    func getData() -> Results<ChatData> {
        return localRealm.objects(ChatData.self)
    }
    
    func fetchData(_ task: ChatData, uid: String) {
        try! localRealm.write {
            task.uid = uid
        }
    }
}
