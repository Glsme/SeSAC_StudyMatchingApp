//
//  FirebaseAPIManager.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/09.
//

import Foundation

import FirebaseAuth

final class FirebaseAPIService {
    static let shared = FirebaseAPIService()
    
    private init() { }
    
    public func requsetPhoneAuth(_ phoneNumber: String, completion: @escaping (Result<String, CertificationError>) -> Void) {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    let errorCode = (error as NSError).code
                    
                    switch errorCode {
                    case 17010:
                        completion(.failure(.tooManyRequest))
                    default:
                        completion(.failure(.etcError))
                    }
                }
                
                if let verificationID = verificationID {
                    completion(.success(verificationID))
                }
            }
    }
}
