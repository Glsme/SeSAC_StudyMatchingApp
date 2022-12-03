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
}

enum CharacterImage: Int {
    case image1 = 0
    case image2 = 1
    case image3 = 2
    case image4 = 3
    case image5 = 4
}
