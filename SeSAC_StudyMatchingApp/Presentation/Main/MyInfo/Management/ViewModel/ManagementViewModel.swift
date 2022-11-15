//
//  ManagementViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import Foundation

import RxDataSources
import RxSwift

struct ManagementCell {
    let title: String?
    
    init(title: String?) {
        self.title = title
    }
}

struct SectionOfManagementCell {
    var header: String
    var items: [Item]
}

extension SectionOfManagementCell: SectionModelType {
    typealias Item = ManagementCell
    
    init(original: SectionOfManagementCell, items: [Item]) {
        self = original
        self.items = items
    }
}

final class ManagementViewModel {
    var userInfo = BehaviorSubject<SeSACInfo>(value: SeSACInfo())
    let titles: [ManagementCell] = [ManagementCell(title: nil),
                                    ManagementCell(title: nil),
                                   ManagementCell(title: "내 성별"),
                                   ManagementCell(title: "자주 하는 스터디"),
                                   ManagementCell(title: "내 번호 검색 허용"),
                                   ManagementCell(title: "상대방 연령대"),
                                   ManagementCell(title: "회원 탈퇴"),]
    
    func setProfileImage() -> [String] {
        guard let userInfo = try? userInfo.value() else { return ["", ""] }
        var background = ""
        var profile = ""
        
        switch userInfo.background {
        case 0:
            background = SesacBGAssets.sesacBG1.rawValue
        case 1:
            background = SesacBGAssets.sesacBG2.rawValue
        case 2:
            background = SesacBGAssets.sesacBG3.rawValue
        case 3:
            background = SesacBGAssets.sesacBG4.rawValue
        case 4:
            background = SesacBGAssets.sesacBG5.rawValue
        case 5:
            background = SesacBGAssets.sesacBG6.rawValue
        case 6:
            background = SesacBGAssets.sesacBG7.rawValue
        case 7:
            background = SesacBGAssets.sesacBG8.rawValue
        case 8:
            background = SesacBGAssets.sesacBG9.rawValue
        default:
            break
        }
        
        switch userInfo.sesac {
        case 0:
            profile = SesacCharaterAssets.sesacFace1.rawValue
        case 1:
            profile = SesacCharaterAssets.sesacFace2.rawValue
        case 2:
            profile = SesacCharaterAssets.sesacFace3.rawValue
        case 3:
            profile = SesacCharaterAssets.sesacFace4.rawValue
        case 4:
            profile = SesacCharaterAssets.sesacFace5.rawValue
        default:
            break
        }
        
        return [background, profile]
    }
}
