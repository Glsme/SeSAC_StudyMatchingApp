//
//  MyQueueStateError.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/20.
//

import Foundation

enum MyQueueStateResponse: Int, Error {
    case normal = 201
    case firebaseError = 401
    case noSignup = 406
    case serverError = 500
    case clientError = 501
}
