//
//  Ments.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import Foundation

//MARK: - Onboarding
enum OnboardingMents: String {
    case firstOnboardingMent = "위치 기반으로 빠르게\n주위 친구를 확인"
    case secondOnboardingMent = "스터디를 원하는 친구를 찾을 수 있어요"
    case thridOnboardingMent = "SeSAC Study"
    case firstOnboardingHighlightMent = "위치 기반"
    case secondOnboardingHighlightMent = "스터디를 원하는 친구"
}

//MARK: - Certification Request
enum CertificationRequestMents: String {
    case description = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해주세요"
    case placeholder = "휴대폰 번호(-없이 숫자만 입력)"
    case buttonText = "인증 문자 받기"
}

//MARK: - Certification Receiving
enum CertificationReceivingMents: String {
    case description = "인증번호가 문자로 전송되었어요"
    case placeholder = "인증번호 입력"
    case startButtonText = "인증하고 시작하기"
    case reSendButtonText = "재전송"
}
