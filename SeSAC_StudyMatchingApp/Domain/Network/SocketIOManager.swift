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
            .log(true),
            .extraHeaders(["idtoken": UserManager.authVerificationToken ?? ""])
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
        socket.on("sesac") { dataArray, ack in
            print("SESAC RECEIVED", dataArray, ack)
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
