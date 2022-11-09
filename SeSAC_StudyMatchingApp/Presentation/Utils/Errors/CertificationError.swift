//
//  CertificationError.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/08.
//

import Foundation

enum CertificationError: Error {
    case noAuthVerificationID
    case noAuthResult
    case InvalidFormat
    case tooManyRequest
    case etcError
}

extension CertificationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noAuthVerificationID, .noAuthResult:
            return "인증 값이 없습니다."
        case .InvalidFormat:
            return "잘못된 전화번호 형식입니다."
        case .tooManyRequest:
            return "과도한 인증 시도가 있었습니다. 나중에 다시 시도해주세요."
        case .etcError:
            return "에러가 발생했습니다."
        }
    }
}
