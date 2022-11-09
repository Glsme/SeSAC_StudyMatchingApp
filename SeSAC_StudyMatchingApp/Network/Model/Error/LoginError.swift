//
//  LoginError.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import Foundation
import Alamofire

enum LoginError: Int, Error {
    case unregisteredUser = 406
    case serverError = 500
    case clientError = 501
}

extension LoginError {
    var errorDescription: String? {
        switch self {
        case .unregisteredUser:
            return "move to Signup"
        case .serverError:
            return "server Error"
        case .clientError:
            return "client Error"
        }
    }
}
