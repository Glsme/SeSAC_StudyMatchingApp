//
//  MyInfoViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import Foundation

import RxDataSources

struct MyInfoCell {
    var image: String
    var title: String
    
    init(image: String, title: String) {
        self.image = image
        self.title = title
    }
}

struct SectionOfMyInfoCell {
    var header: String
    var items: [Item]
}

extension SectionOfMyInfoCell: SectionModelType {
    typealias Item = MyInfoCell
    
    init(original: SectionOfMyInfoCell, items: [Item]) {
        self = original
        self.items = items
    }
}

class MyInfoViewModel {
    var cellDatas: [MyInfoCell] = [MyInfoCell(image: "", title: "김새싹"),
                                   MyInfoCell(image: MyInfoAssets.notice.rawValue, title: MyInfoMents.notice.rawValue),
                                   MyInfoCell(image: MyInfoAssets.faq.rawValue, title: MyInfoMents.faq.rawValue),
                                   MyInfoCell(image: MyInfoAssets.qna.rawValue, title: MyInfoMents.qna.rawValue),
                                   MyInfoCell(image: MyInfoAssets.settingAlarm.rawValue, title: MyInfoMents.settingAlarm.rawValue),
                                   MyInfoCell(image: MyInfoAssets.permit.rawValue, title: MyInfoMents.permit.rawValue)]
    
    func setCellData() {
        guard let sesac = UserManager.sesac else { return }
        guard let nickname = UserManager.nickname else { return }
        var sesacString = ""
        
        switch sesac {
        case 0:
            sesacString = SesacCharaterAssets.sesacFace1.rawValue
        case 1:
            sesacString = SesacCharaterAssets.sesacFace2.rawValue
        case 2:
            sesacString = SesacCharaterAssets.sesacFace3.rawValue
        case 3:
            sesacString = SesacCharaterAssets.sesacFace4.rawValue
        case 4:
            sesacString = SesacCharaterAssets.sesacFace5.rawValue
        default:
            break
        }
        
        cellDatas[0].image = sesacString
        cellDatas[0].title = nickname
    }
}
