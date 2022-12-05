//
//  ShopSubViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/12/03.
//

import Foundation

class ShopSubViewModel {
    //MARK: 새싹 캐릭터
    var characterProductIdentifiers: Set<String> = ["com.memolease.sesac1.sprout1",
                                                    "com.memolease.sesac1.sprout2",
                                                    "com.memolease.sesac1.sprout3",
                                                    "com.memolease.sesac1.sprout4"]
    
    var characterTitleArray: [String] = ["기본 새싹"]
    var characterPriceArray: [String] = ["0"]
    var characterDescriptionArray: [String] = ["새싹을 대표하는 기본 식물입니다. 다른 새싹들과 함께 하는 것을 좋아합니다."]
    
    //MARK: 새싹 배경
    var bgProductIdentifiers: Set<String> = ["com.memolease.sesac1.background1",
                                             "com.memolease.sesac1.background2",
                                             "com.memolease.sesac1.background3",
                                             "com.memolease.sesac1.background4",
                                             "com.memolease.sesac1.background5",
                                             "com.memolease.sesac1.background6",
                                             "com.memolease.sesac1.background7",]
    
    var bgTitleArray: [String] = ["하늘 공원"]
    var bgPriceArray: [String] = ["0"]
    var bgDescriptionArray: [String] = ["새싹들을 많이 마주치는 매력적인 하늘 공원입니다"]
    
    var shopInfoData: ShopInfo?
    var currentSesacImage: Int = 0
    var currentBGImage: Int = 0
    
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
    
    func setBGImage(index: Int) -> String {
        let image = BackgroundImage(rawValue: index)
        
        switch image {
        case .image1:
            return SesacBGAssets.sesacBG1.rawValue
        case .image2:
            return SesacBGAssets.sesacBG2.rawValue
        case .image3:
            return SesacBGAssets.sesacBG3.rawValue
        case .image4:
            return SesacBGAssets.sesacBG4.rawValue
        case .image5:
            return SesacBGAssets.sesacBG5.rawValue
        case .image6:
            return SesacBGAssets.sesacBG6.rawValue
        case .image7:
            return SesacBGAssets.sesacBG7.rawValue
        case .image8:
            return SesacBGAssets.sesacBG8.rawValue
        case .none:
            return SesacBGAssets.sesacBG1.rawValue
        }
    }
    
    func setbgTitle(index: Int) -> String {
        guard index < bgTitleArray.count else { return "" }
        return bgTitleArray[index]
    }
    
    func setbgDescription(index: Int) -> String {
        guard index < bgDescriptionArray.count else { return "" }
        return bgDescriptionArray[index]
    }
    
    func setbgPrice(index: Int) -> String {
        guard index < bgPriceArray.count else { return "" }
        return bgPriceArray[index]
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
    
    func updateProfile(sesac: Int, background: Int, completion: @escaping (ProfileUpdate) -> Void) {
        let api = SesacAPIUserRouter.shopItemPost(sesac: sesac, background: background)
        
        SesacSignupAPIService.shared.requestUpdateProfile(router: api) { statusCode in
            let statusCode = ProfileUpdate(rawValue: statusCode)
            
            completion(statusCode ?? ProfileUpdate.clientError)
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

enum BackgroundImage: Int {
    case image1 = 0
    case image2 = 1
    case image3 = 2
    case image4 = 3
    case image5 = 4
    case image6 = 5
    case image7 = 6
    case image8 = 7
}

enum ProfileUpdate: Int {
    case success = 200
    case dontHaveItem = 201
    case firebaseTokenError = 401
    case noSignup = 406
    case serverError = 500
    case clientError = 501
}
