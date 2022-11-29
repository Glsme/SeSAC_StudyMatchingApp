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
    
    func getData() -> Results<ChatData> {
        return localRealm.objects(ChatData.self)
    }
}
