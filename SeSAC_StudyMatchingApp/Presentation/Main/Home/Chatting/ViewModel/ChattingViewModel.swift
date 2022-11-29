//
//  ChattingViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/23.
//

import Foundation

import RealmSwift
import RxDataSources
import RxSwift

struct MessageCell {
    var message: Payload
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
    var mychatData: MyChat = MyChat(payload: [])
    var chat = PublishSubject<[SectionOfMessageCell]>()
    var payloadArray: [Payload] = []
    var sections: [SectionOfMessageCell] = []
    var tasks: Results<ChatData>!
    
    func fetchChats() {
        getChat()
        SocketIOManager.shared.establishConnection()
    }
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일 EEEE"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
    }()
    
    let iso8601DateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter
    }()
    
    let timeFormatter: DateFormatter = {
        let timeForatter = DateFormatter()
        timeForatter.dateFormat = "HH:mm"
        timeForatter.timeZone = TimeZone(identifier: "UTC+18")
        return timeForatter
    }()
    
    func postChat(_ text: String, completion: @escaping (Int) -> Void) {
        guard let data = data else { return }
        guard let uid = data.matchedUid else { return }
        let api = SesacAPIRouter.chatPost(chat: text, uid: uid)
        
        SesacSignupAPIService.shared.requestPostChat(router: api) { statusCode in
            completion(statusCode)
        }
    }
    
    func getChat() {
        guard let data = data else { return }
        guard let uid = data.matchedUid else { return }
        
        tasks = ChatRepository.shared.fetchChatData(uid: uid)
        
        guard let task = tasks.first else { return }

        let chatData = transChatDataToMyChat(task)
        inputChatData(data: chatData) { _, _ in }
        
        guard let targetDateString = chatData.payload.last?.createdAt else { return }
        
        let date: String = targetDateString
        let api = SesacAPIRouter.chatGet(lastDate: date, uid: uid)
        
        SesacSignupAPIService.shared.requestGetChat(router: api) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let success):
                self.mychatData = success
                self.inputChatData(data: success) { _, _ in }
//                self.pushAllData(success)
            case .failure(let error):
                print("error:: \(error)")
            }
        }
    }
    
    func transChatDataToMyChat(_ chatData: ChatData) -> MyChat {
        var mychat = MyChat(payload: [])
        
        chatData.chatList.forEach {
            let payload: Payload = Payload(id: $0.id, to: $0.to, from: $0.from, chat: $0.chat, createdAt: $0.createdAt)
            
            mychat.payload.append(payload)
        }
        
        return mychat
    }
    
    func inputChatData(data: MyChat, completion: @escaping (Int, Int) -> Void) {
        guard !data.payload.isEmpty else { return }
        guard var date = data.payload[0].createdAt.toDate() else { return }
        payloadArray.append(data.payload[0])
        
        data.payload.forEach {
            guard let targetDate = $0.createdAt.toDate() else { return }
            //가장 오래된 데이터의 날짜 값이 targetDate와 다르면 Section 추가
            if dateFormatter.string(from: date) != dateFormatter.string(from: targetDate) {
                guard let nexDate = $0.createdAt.toDate() else { return }
                date = nexDate
                
                payloadArray.append($0)
            }
        }
        
        for date in payloadArray {
            var section: [MessageCell] = []
            guard let currentDate = date.createdAt.toDate() else { return }
            
            section.append(MessageCell(message: date))
            
            for chat in data.payload {
                guard let targetDate = chat.createdAt.toDate() else { return }
                
                if dateFormatter.string(from: currentDate) == dateFormatter.string(from: targetDate) {
                    section.append(MessageCell(message: chat))
                }
            }
            
            sections.append(SectionOfMessageCell(header: "\(section.count)", items: section))
        }
        
        chat.onNext(sections)
        
        guard let itemsCount = sections.last?.items.count else { return }
        
        completion(sections.count - 1, itemsCount - 1)
    }
    
    func pushAllData(_ chat: MyChat) {
        guard let uid = data?.matchedUid else { return }
        
        let chatArray = List<ChatListData>()
        
        for item in chat.payload {
            let chat = ChatListData(id: item.id, to: item.to, from: item.from, chat: item.chat, createdAt: item.createdAt)
            
            chatArray.append(chat)
        }
        
        let chatData: ChatData = ChatData(uid: uid, chatList: chatArray)
        
        ChatRepository.shared.write(chatData)
    }
    
    func savePostData(_ task: Payload) {
        guard let uid = data?.matchedUid else { return }
        
        var chatData: ChatData = ChatData(uid: "", chatList: List<ChatListData>())
        
        for item in ChatRepository.shared.localRealm.objects(ChatData.self) {
            if item.uid == uid {
                chatData = item
                break
            }
        }
        
        ChatRepository.shared.chatWrite(task, chatData: chatData)
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
