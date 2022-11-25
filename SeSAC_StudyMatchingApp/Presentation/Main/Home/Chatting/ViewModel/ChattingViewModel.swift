//
//  ChattingViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/23.
//

import Foundation

import RxDataSources

struct MessageCell {
    var message: String
    
    init(message: String) {
        self.message = message
    }
}

struct SectionOfMessageCell {
    var header: String
    var items: [Item]
}

extension SectionOfMessageCell: SectionModelType {
    typealias Item = MessageCell
    
    init(original: SectionOfMessageCell, items: [Item]) {
        self = original
        self.items = items
    }
}

class ChattingViewModel: CommonViewModel {
    var data: MyQueueState?
    var chat: [MyChat] = []
    
    func fetchChats() {
        SocketIOManager.shared.establishConnection()
    }
    
    func postChat(_ text: String) {
        guard let data = data else { return }
        guard let uid = data.matchedUid else { return }
        let api = SesacAPIRouter.chatPost(chat: text, uid: uid)
        SesacSignupAPIService.shared.requestPostChat(router: api) { statusCode in
            if ChattingCode(rawValue: statusCode) == .success {
                print("Post Success")
            } else {
                print(ChattingCode(rawValue: statusCode)!)
            }
        }
    }
}

enum ChattingCode: Int {
    case success = 200
    case postFail = 201
    case firebaseTockenError = 401
    case noSignup = 406
    case serverError = 500
    case clientError = 501
}
