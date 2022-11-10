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
    case validFormat = "전화 번호 인증 시작"
}

//MARK: - Certification Receiving
enum CertificationReceivingMents: String {
    case description = "인증번호가 문자로 전송되었어요"
    case placeholder = "인증번호 입력"
    case startButtonText = "인증하고 시작하기"
    case reSendButtonText = "재전송"
    case sendNumber = "인증번호를 보냈습니다."
    case notSixNumber = "인증 번호 6자리를 입력해주세요"
    case timeOver = "토큰이 만료되었습니다.\n재전송 버튼을 눌러주세요."
}

//MARK: - Signup
enum SignupMents: String {
    case nextButton = "다음"
    
    //MARK: - Nickname
    case nicknameDescription = "닉네임을 입력해 주세요"
    case nicknamePlaceholder = "10자 이내로 입력"
    
    //MARK: - Birth
    case birthDescription = "생년월일을 알려주세요"
    case ageError = "새싹스터디는 만 17세 이상만 사용할 수 있습니다."
    
    //MARK: - E-mail
    case emailMainDescription = "이메일을 입력해 주세요"
    case emailSubDescription = "휴대폰 번호 변경 시 인증을 위해 사용해요"
    case emailPlaceHolder = "SeSAC@email.com"
    
    case genderMainDescription = "성별을 선택해 주세요"
    case genderSubSDescription = "새싹 찾기 기능을 이용하기 위해서 필요해요!"
    
}
