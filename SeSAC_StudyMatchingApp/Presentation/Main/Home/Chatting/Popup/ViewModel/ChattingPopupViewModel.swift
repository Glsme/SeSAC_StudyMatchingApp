//
//  ChattingPopupViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/30.
//

import Foundation

class ChattingPopupViewModel: CommonViewModel {
    var uid: String = ""
    
    func requestDodge(uid: String, completion: @escaping () -> Void) {
        let api = SesacAPIRouter.studyDodge(uid: uid)
        SesacSignupAPIService.shared.requestPostChat(router: api) { [weak self] statusCode in
            guard let self = self else { return }
            if DodgeResponseCode(rawValue: statusCode) == .success {
                completion()
            } else {
                if DodgeResponseCode(rawValue: statusCode) == .firebaseError {
                    self.refreshToken {
                        SesacSignupAPIService.shared.requestPostChat(router: api) { statusCode in
                            if DodgeResponseCode(rawValue: statusCode) == .success {
                                completion()
                            } else {
                                print(DodgeResponseCode(rawValue: statusCode))
                            }
                        }
                    }
                }
            }
        }
    }
    
    func requestReview(uid: String, reputation: Array<Int>, comment: String, completion: @escaping () -> Void) {
        let data: UserReview = UserReview(uid: uid, reputation: reputation, comment: comment)
        let api = SesacAPIRouter.ratePost(data: data)
        
        SesacSignupAPIService.shared.requestPostChat(router: api) { statusCode in
            if DodgeResponseCode(rawValue: statusCode) == .success {
                completion()
            } else {
                print(DodgeResponseCode(rawValue: statusCode))
            }
        }
    }
}

struct UserReview {
    let uid: String
    let reputation: Array<Int>
    let comment: String
}

enum DodgeResponseCode: Int {
    case success = 200
    case wrongOtherUid = 201
    case firebaseError = 401
    case noSignup = 406
    case serverError = 500
    case ClentError = 501
}
