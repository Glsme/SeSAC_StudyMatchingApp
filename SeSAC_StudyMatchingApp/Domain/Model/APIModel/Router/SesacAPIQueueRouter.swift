//
//  SesacAPIQueueRouter.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/12/04.
//

import Foundation

import Alamofire

enum SesacAPIQueueRouter: URLRequestConvertible {
    case searchPost(lat: String, long: String)
    case searchSesacPost(data: SearchSesacData)
    case myQueueStateGet
    case myQueueStateDelete
    case studyRequsetPost(uid: String)
    case studyAccept(uid: String)
    case studyDodge(uid: String)
    case ratePost(data: UserReview)
    
    var baseURL: URL {
        switch self {
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
        case .studyDodge:
            return URL(string: "http://api.sesac.co.kr:1210/v1/queue/dodge")!
        case .ratePost:
            return URL(string: "http://api.sesac.co.kr:1210/v1/queue/rate")!
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchPost: return .post
        case .searchSesacPost: return .post
        case .myQueueStateGet: return .get
        case .myQueueStateDelete: return .delete
        case .studyRequsetPost: return .post
        case .studyAccept: return .post
        case .studyDodge: return .post
        case .ratePost: return .post
        }
    }
    
    var headers: HTTPHeaders {
        guard let idToken = UserManager.authVerificationToken else { return ["": ""] }
        return ["Content-Type": "application/x-www-form-urlencoded",
                "accept": "*/*",
                "idtoken": idToken]
    }
    
    var parameters: [String: Any] {
        switch self {
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
        case .studyDodge(let uid):
            return ["otheruid": uid]
        case .ratePost(let data):
            return ["otheruid": data.uid, "reputation": data.reputation, "comment": data.comment]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = baseURL
        
        switch self {
        case .ratePost(let data):
            url = url.appendingPathComponent(data.uid)
        default:
            break
        }
        
        var request = URLRequest(url: url)
        
        request.method = method
        request.headers = headers
        
        return try URLEncoding(arrayEncoding: .noBrackets).encode(request, with: parameters)
    }
}
