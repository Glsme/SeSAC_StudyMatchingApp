//
//  SesacAPIUserRouter.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/28.
//

import Foundation

import Alamofire

enum SesacAPIUserRouter: URLRequestConvertible {
    case loginGet
    case signupPost
    case updatePut(mypage: MypageUpdate)
    case withdraw
    case updateFCMPut(fcmToken: String)
    case shopMyInfo
    case shopIOS(receipt: String, product: String)
    
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
        case .updateFCMPut:
            return URL(string: "http://api.sesac.co.kr:1210/v1/user/update_fcm_token")!
        case .shopMyInfo:
            return URL(string: "http://api.sesac.co.kr:1210/v1/user/shop/myinfo")!
        case .shopIOS:
            return URL(string: "http://api.sesac.co.kr:1210/v1/user/shop/ios")!
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .loginGet: return .get
        case .signupPost: return .post
        case .updatePut: return .put
        case .withdraw: return .post
        case .updateFCMPut: return .put
        case .shopMyInfo: return .get
        case .shopIOS: return .post
        }
    }
    
    var headers: HTTPHeaders {
        guard let idToken = UserManager.authVerificationToken else { return ["idtoken": ""] }
        return ["idtoken": idToken,
                "Content-Type": "application/x-www-form-urlencoded",
                "accept": "application/json"]
    }
    
    var parameters: [String: Any] {
        switch self {
        case .loginGet, .withdraw, .shopMyInfo:
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
        case .updateFCMPut(let fcmToken):
            return ["FCMtoken": fcmToken]
        case .shopIOS(let receipt, let product):
            return ["receipt": receipt, "product": product]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
        var request = URLRequest(url: url)
        
        request.method = method
        request.headers = headers
        
        return try URLEncoding(arrayEncoding: .noBrackets).encode(request, with: parameters)
    }
}
