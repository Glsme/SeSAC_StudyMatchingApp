//
//  SesacAPIRouter.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import Foundation

import Alamofire

enum SesacAPIRouter: URLRequestConvertible {
    case loginGet
    case signupPost
    case updatePut(mypage: MypageUpdate)
    case withdraw
    case searchPost(lat: String, long: String)
    case searchSesacPost(data: SearchSesacData)
    case myQueueStateGet
    case myQueueStateDelete
    case studyRequsetPost(uid: String)
    case studyAccept(uid: String)
    case chatPost(chat: String, uid: String)
    case chatGet(lastDate: String, uid: String)
    
    var baseURL: URL {
        switch self {
        case .loginGet:
            return URL(string: "http://api.sesac.co.kr:1210/v1/user")!
        case .signupPost:
            return URL(string: "http://api.sesac.co.kr:1210/v1/user")!
        case .updatePut(mypage: _):
            return URL(string: "http://api.sesac.co.kr:1210/v1/user/mypage")!
        case .withdraw:
            return URL(string: "http://api.sesac.co.kr:1210/v1/user/withdraw")!
        case .searchPost:
            return URL(string: "http://api.sesac.co.kr:1210/v1/queue/search")!
        case .searchSesacPost, .myQueueStateDelete:
            return URL(string: "http://api.sesac.co.kr:1210/v1/queue")!
        case .myQueueStateGet:
            return URL(string: "http://api.sesac.co.kr:1210/v1/queue/myQueueState")!
        case .studyRequsetPost:
            return URL(string: "http://api.sesac.co.kr:1210/v1/queue/studyrequest")!
        case .studyAccept:
            return URL(string: "http://api.sesac.co.kr:1210/v1/queue/studyaccept")!
        case . chatPost:
            return URL(string: "http://api.sesac.co.kr:1210/v1/chat")!
        case .chatGet:
            return URL(string: "http://api.sesac.co.kr:1210/v1/chat")!
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .loginGet: return .get
        case .signupPost: return .post
        case .updatePut: return .put
        case .withdraw: return .post
        case .searchPost: return .post
        case .searchSesacPost: return .post
        case .myQueueStateGet: return .get
        case .myQueueStateDelete: return .delete
        case .studyRequsetPost: return .post
        case .studyAccept: return .post
        case .chatPost: return .post
        case .chatGet: return .get
        }
    }
    
//    var path: String {
//        switch self {
//        case .loginGet: return "get"
//        case .signupPost: return "post"
//        }
//    }
    
    var headers: HTTPHeaders {
        switch self {
        case .loginGet:
            guard let idToken = UserManager.authVerificationToken else { return ["idtoken": ""] }
            return ["idtoken": idToken,
                    "Content-Type": "application/x-www-form-urlencoded",
                    "accept": "application/json"]
        case .signupPost:
            guard let idToken = UserManager.authVerificationToken else { return ["": ""] }
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "accept": "*/*",
                    "idtoken": idToken]
        case .updatePut:
            guard let idToken = UserManager.authVerificationToken else { return ["": ""] }
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "accept": "*/*",
                    "idtoken": idToken]
        case .withdraw:
            guard let idToken = UserManager.authVerificationToken else { return ["": ""] }
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "accept": "*/*",
                    "idtoken": idToken]
        case .searchPost:
            guard let idToken = UserManager.authVerificationToken else { return ["": ""] }
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "accept": "*/*",
                    "idtoken": idToken]
            
        case .searchSesacPost:
            guard let idToken = UserManager.authVerificationToken else { return ["": ""] }
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "accept": "*/*",
                    "idtoken": idToken]
        case .myQueueStateGet:
            guard let idToken = UserManager.authVerificationToken else { return ["": ""] }
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "accept": "*/*",
                    "idtoken": idToken]
        case .myQueueStateDelete:
            guard let idToken = UserManager.authVerificationToken else { return ["": ""] }
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "accept": "*/*",
                    "idtoken": idToken]
        case .studyRequsetPost:
            guard let idToken = UserManager.authVerificationToken else { return ["": ""] }
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "accept": "*/*",
                    "idtoken": idToken]
        case .studyAccept:
            guard let idToken = UserManager.authVerificationToken else { return ["": ""] }
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "accept": "*/*",
                    "idtoken": idToken]
        case .chatPost:
            guard let idToken = UserManager.authVerificationToken else { return ["": ""] }
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "accept": "*/*",
                    "idtoken": idToken]
        case .chatGet:
            guard let idToken = UserManager.authVerificationToken else { return ["": ""] }
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "accept": "*/*",
                    "idtoken": idToken]
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .loginGet:
            return ["": ""]
        case .signupPost:
            guard let phoneNumber = UserManager.phoneNumber else { return ["": ""] }
            guard let fcmToken = UserManager.fcmToken else { return ["": ""] }
            guard let nick = UserManager.nickname else { return ["": ""] }
            guard let birth = UserManager.birth else { return ["": ""] }
            guard let email = UserManager.email else { return ["": ""] }
            guard let gender = UserManager.gender else { return ["": ""] }
            return ["phoneNumber": phoneNumber,
                    "FCMtoken": fcmToken,
                    "nick": nick,
                    "birth": birth,
                    "email": email,
                    "gender": "\(gender)"]
        case .updatePut(let myPage):
            return ["searchable": String(myPage.searchable),
                    "ageMin": String(myPage.ageMin),
                    "ageMax": String(myPage.ageMax),
                    "gender": String(myPage.gender),
                    "study": myPage.study]
        case .withdraw:
            return ["": ""]
        case .searchPost(let lat, let long):
            return ["lat": lat, "long": long]
        case .searchSesacPost(let data):
            return ["long": data.long, "lat" : data.lat, "studylist": data.studylist]
        case .myQueueStateGet:
            return ["": ""]
        case .myQueueStateDelete:
            return ["": ""]
        case .studyRequsetPost(let uid):
            return ["otheruid": uid]
        case .studyAccept(let uid):
            return ["otheruid": uid]
        case .chatPost(let chat, _):
            return ["chat": chat]
        case .chatGet(let date, _):
            return ["lastchatDate": date]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = baseURL
        
        switch self {
        case .chatPost(_, let uid):
            url = url.appendingPathComponent(uid)
        case .chatGet(_, let uid):
            url = url.appendingPathComponent(uid)
        default:
            break
        }
        
        var request = URLRequest(url: url)
        
        request.method = method
        request.headers = headers
        
        return try URLEncoding(arrayEncoding: .noBrackets).encode(request, with: parameters)
    }
}
