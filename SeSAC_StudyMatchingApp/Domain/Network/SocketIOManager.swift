//
//  SocketIOManager.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/25.
//

import Foundation

import SocketIO

class SocketIOManager {
    static let shared = SocketIOManager()
    
    // 서버와 메시지를 주고 받기 위한 클래스
    var manager: SocketManager!
    var socket: SocketIOClient
    private init() {
        manager = SocketManager(socketURL: URL(string: APIKey.socket)!, config: [
            .forceWebsockets(true)
//            .extraHeaders(["idtoken": UserManager.authVerificationToken ?? ""])
        ])
        
        socket = manager.defaultSocket
        
        // 연결
        socket.on(clientEvent: .connect) { data, ack in
            print("Socket is connected", data, ack)
            self.socket.emit("changesocketid", UserManager.myUid ?? "")
        }
        
        // 연결 해제
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        
        //이벤트 수신
        socket.on("chat") { dataArray, ack in
            print("SESAC RECEIVED", dataArray, ack)
            
            let data = dataArray[0] as! NSDictionary
            let id = data["_id"] as! String
            let chat = data["chat"] as! String
            let to = data["to"] as! String
            let from = data["from"] as! String
            let createdAt = data["createdAt"] as! String
            
//            print("CHECK >>>", chat, createdAt)
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["chat": chat, "id": id, "to": to, "from": from, "createdAt": createdAt])
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
