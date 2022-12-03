//
//  ShopSubViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/12/03.
//

import Foundation

class ShopSubViewModel {
    func setCharacterImage(index: Int) -> String {
        let image = CharacterImage(rawValue: index)
        
        switch image {
        case .image1:
            return SesacCharaterAssets.sesacFace1.rawValue
        case .image2:
            return SesacCharaterAssets.sesacFace2.rawValue
        case .image3:
            return SesacCharaterAssets.sesacFace3.rawValue
        case .image4:
            return SesacCharaterAssets.sesacFace4.rawValue
        case .image5:
            return SesacCharaterAssets.sesacFace5.rawValue
        case .none:
            return ""
        }
    }
    
    func setCharacterTitle(index: Int) -> String {
        let title = CharacterImage(rawValue: index)
        
        switch title {
        case .image1:
            return "기본 새싹"
        case .image2:
            return "튼튼 새싹"
        case .image3:
            return "민트 새싹"
        case .image4:
            return "퍼플 새싹"
        case .image5:
            return "골드 새싹"
        case .none:
            return ""
        }
    }
    
    func setCharacterDescription(index: Int) -> String {
        let description = CharacterImage(rawValue: index)
        
        switch description {
        case .image1:
            return "새싹을 대표하는 기본 식물입니다. 다른 새싹들과 함께 하는 것을 좋아합니다."
        case .image2:
            return "잎이 하나 더 자라나고 튼튼해진 새나라의 새싹으로 같이 있으면 즐거워집니다."
        case .image3:
            return "호불호의 대명사! 상쾌한 향이 나서 허브가 대중화된 지역에서 많이 자랍니다."
        case .image4:
            return "감정을 편안하게 쉬도록 하며 슬프고 우울한 감정을 진정시켜주는 멋진 새싹입니다."
        case .image5:
            return "화려하고 멋있는 삶을 살며 돈과 인생을 플렉스 하는 자유분방한 새싹입니다."
        case .none:
            return ""
        }
    }
}

enum CharacterImage: Int {
    case image1 = 0
    case image2 = 1
    case image3 = 2
    case image4 = 3
    case image5 = 4
}
