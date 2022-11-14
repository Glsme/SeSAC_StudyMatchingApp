//
//  ManagementViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import Foundation

import RxDataSources

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

final class ManagementViewModel: CommonViewModel {
    let titles: [ManagementCell] = [ManagementCell(title: nil),
                                   ManagementCell(title: nil),
                                   ManagementCell(title: "내 성별"),
                                   ManagementCell(title: "자주 하는 스터디"),
                                   ManagementCell(title: "내 번호 검색 허용"),
                                   ManagementCell(title: "상대방 연령대"),
                                   ManagementCell(title: "회원 탈퇴"),]
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
}
