//
//  ShopSubViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/12/03.
//

import Foundation

class ShopSubViewModel {
    var characterProductIdentifiers: Set<String> = ["com.memolease.sesac1.sprout1",
                                                    "com.memolease.sesac1.sprout2",
                                                    "com.memolease.sesac1.sprout3",
                                                    "com.memolease.sesac1.sprout4"]
    
    var characterTitleArray: [String] = ["기본 새싹"]
    var characterPriceArray: [String] = ["0"]
    var characterDescriptionArray: [String] = ["새싹을 대표하는 기본 식물입니다. 다른 새싹들과 함께 하는 것을 좋아합니다."]
    var shopInfoData: ShopInfo?
    
    let numberFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f
    }()
    
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
            return SesacCharaterAssets.sesacFace1.rawValue
        }
    }
    
    func setCharacterTitle(index: Int) -> String {
        guard index < characterTitleArray.count else { return "" }
        return characterTitleArray[index]
    }
    
    func setCharacterDescription(index: Int) -> String {
        guard index < characterDescriptionArray.count else { return "" }
        return characterDescriptionArray[index]
    }
    
    func setCharacterPrice(index: Int) -> String {
        guard index < characterPriceArray.count else { return "" }
        return characterPriceArray[index]
    }
    
    func requestShopMyInfo(completion: @escaping (ShopInfo) -> Void) {
        let api = SesacAPIUserRouter.shopMyInfo
        
        SesacSignupAPIService.shared.requestShopInfo(router: api) { response in
            switch response {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func requestPushReceipt(receipt: String, product: String, completion: @escaping () -> Void) {
        let api = SesacAPIUserRouter.shopIOS(receipt: receipt, product: product)
        
        SesacSignupAPIService.shared.requestFCMTokenUpdate(router: api) { [weak self] statusCode in
            guard let self = self else { return }
            if statusCode == 200 {
                self.requestShopMyInfo { data in
                    self.shopInfoData = data
                    completion()
                }
            } else {
                print(statusCode)
            }
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
