//
//  CertificationError.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/08.
//

import Foundation

enum CertificationError: Error {
    case noAuthVerificationID
}

extension CertificationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noAuthVerificationID:
            return "인증 값이 없습니다."
        }
    }
}
