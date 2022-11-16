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
    
    var baseURL: URL {
        switch self {
        case .loginGet:
            return URL(string: "http://api.sesac.co.kr:1207/v1/user")!
        case .signupPost:
            return URL(string: "http://api.sesac.co.kr:1207/v1/user")!
        case .updatePut(mypage: _):
            return URL(string: "http://api.sesac.co.kr:1207/v1/user/mypage")!
        case .withdraw:
            return URL(string: "http://api.sesac.co.kr:1207/v1/user/withdraw")!
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .loginGet: return .get
        case .signupPost: return .post
        case .updatePut: return .put
        case .withdraw: return .post
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
        }
    }
    
    var parameters: [String: String] {
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
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers
        
        return try URLEncoding.default.encode(request, with: parameters)
//        return request
    }
}
