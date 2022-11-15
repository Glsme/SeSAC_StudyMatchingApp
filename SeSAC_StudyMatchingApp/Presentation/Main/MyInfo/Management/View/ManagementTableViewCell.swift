//
//  ManagementTableViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/15.
//

import UIKit

import SnapKit

class ManagementTableViewCell: UITableViewCell {
    lazy var genderView = CustomGenderView()
    lazy var studyView = CustomStudyView()
    lazy var phoneView = CustomPhoneView()
    lazy var ageView = CustomAgeView()
    lazy var withdrawView = CustomWithdrawView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        selectionStyle = .none
        [genderView, studyView, phoneView, ageView, withdrawView].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        genderView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.height.equalTo(75)
        }
        
        studyView.snp.makeConstraints { make in
            make.top.equalTo(genderView.snp.bottom)
            make.trailing.equalTo(genderView.snp.trailing)
            make.leading.equalTo(genderView.snp.leading)
            make.height.equalTo(75)
        }
        
        phoneView.snp.makeConstraints { make in
            make.top.equalTo(studyView.snp.bottom)
            make.trailing.equalTo(studyView.snp.trailing)
            make.leading.equalTo(studyView.snp.leading)
            make.height.equalTo(75)
        }
        
        ageView.snp.makeConstraints { make in
            make.top.equalTo(phoneView.snp.bottom)
            make.trailing.equalTo(phoneView.snp.trailing)
            make.leading.equalTo(phoneView.snp.leading)
            make.height.equalTo(110)
        }
        
        withdrawView.snp.makeConstraints { make in
            make.top.equalTo(ageView.snp.bottom)
            make.trailing.equalTo(ageView.snp.trailing)
            make.leading.equalTo(ageView.snp.leading)
            make.height.equalTo(75)
        }
    }
}
