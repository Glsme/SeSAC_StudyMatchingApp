//
//  ManagementView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import UIKit

import SnapKit

class ManagementView: UIScrollView {
    
    lazy var genderView = CustomGenderView()
    lazy var studyView = CustomStudyView()
    lazy var phoneView = CustomPhoneView()
    lazy var ageView = CustomAgeView()
    lazy var withdrawView = CustomWithdrawView()
    
    let contentView = UIView()
    
    let test1: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let test2: UIView = {
        let view = UIView()
        view.backgroundColor = .sesacGray2
        return view
    }()
    
    let test3: UIView = {
        let view = UIView()
        view.backgroundColor = .sesacFocus
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureUI() {
        self.addSubview(contentView)
                
        [test1, test2, genderView, studyView, phoneView, ageView, withdrawView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(16)
            make.centerX.top.bottom.equalToSuperview()
        }
        
        test1.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        genderView.snp.makeConstraints { make in
            make.top.equalTo(test1.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(75)
        }
        
        studyView.snp.makeConstraints { make in
            make.top.equalTo(genderView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(genderView.snp.height)
        }
        
        phoneView.snp.makeConstraints { make in
            make.top.equalTo(studyView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(genderView.snp.height)
        }
        
        ageView.snp.makeConstraints { make in
            make.top.equalTo(phoneView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        withdrawView.snp.makeConstraints { make in
            make.top.equalTo(ageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(genderView.snp.height)
            make.bottom.equalToSuperview()
        }
    }
}
