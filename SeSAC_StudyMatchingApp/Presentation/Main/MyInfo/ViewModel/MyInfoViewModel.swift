//
//  MyInfoViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import Foundation

import RxDataSources

struct MyInfoCell {
    let image: String
    let title: String
    
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

class MyInfoViewModel: CommonViewModel {
    let cellDatas: [MyInfoCell] = [MyInfoCell(image: MyInfoAssets.notice.rawValue, title: MyInfoMents.notice.rawValue),
                                   MyInfoCell(image: MyInfoAssets.faq.rawValue, title: MyInfoMents.faq.rawValue),
                                   MyInfoCell(image: MyInfoAssets.qna.rawValue, title: MyInfoMents.qna.rawValue),
                                   MyInfoCell(image: MyInfoAssets.settingAlarm.rawValue, title: MyInfoMents.settingAlarm.rawValue),
                                   MyInfoCell(image: MyInfoAssets.permit.rawValue, title: MyInfoMents.permit.rawValue)]

    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
