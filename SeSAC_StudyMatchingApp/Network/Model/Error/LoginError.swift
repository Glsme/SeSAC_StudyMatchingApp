//
//  LoginError.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import Foundation

enum LoginError: Int, Error {
    case alreadySignup = 201
    case cantUseNickname = 202
    case firbaseTokenError = 401
    case unregisteredUser = 406
    case serverError = 500
    case clientError = 501
}

extension LoginError {
    var errorDescription: String? {
        switch self {
        case .alreadySignup:
            return "alreadySignup"
        case .cantUseNickname:
            return "cantUseNickname"
        case .firbaseTokenError:
            return "firbaseTokenError"
        case .unregisteredUser:
            return "unregisteredUser"
        case .serverError:
            return "serverError"
        case .clientError:
            return "clientError"
        }
    }
}
