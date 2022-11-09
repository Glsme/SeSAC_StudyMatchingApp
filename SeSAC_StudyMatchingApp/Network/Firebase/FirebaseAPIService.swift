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
    
    public func requsetSignIn(verificationID: String, verificationCode: String, completion: @escaping (Result<AuthDataResult, CertificationError>) -> Void) {
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                let errorCode = (error as NSError).code
                
                switch errorCode {
                case 17043:
                    completion(.failure(.missingVerificationID))
                case 17044:
                    completion(.failure(.invalidVerificationCode))
                case 17045:
                    completion(.failure(.missingVerificationID))
                default:
                    completion(.failure(.etcError))
                }
            } else {
                guard let result = authResult else {
                    completion(.failure(.etcError))
                    return
                }
                
                completion(.success(result))
            }
        }

    }
}
