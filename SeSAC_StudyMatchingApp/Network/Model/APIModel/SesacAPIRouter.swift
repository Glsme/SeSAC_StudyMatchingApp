//
//  SesacAPIRouter.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import Foundation

import Alamofire

enum SesacAPIRouter: URLRequestConvertible {
    case loginGet, loginPost
    
    var baseURL: URL {
        return URL(string: "http://api.sesac.co.kr:1207/v1/user")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .loginGet: return .get
        case .loginPost: return .post
        }
    }
    
    var path: String {
        switch self {
        case .loginGet: return "get"
        case .loginPost: return "post"
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .loginGet:
            guard let idToken = UserManager.authVerificationToken else { return ["idtoken": ""] }
            return ["idtoken": idToken,
                    "Content-Type": "application/x-www-form-urlencoded",
                    "Accept": "application/json"]
        case .loginPost:
            return ["": ""]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers
        
        return request
    }
}
