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
    lazy var cardView = ProfileCardView()
    
    let contentView = UIView()
    
    let test2: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [cardView, genderView, studyView, phoneView, ageView, withdrawView])
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureUI() {
        self.addSubview(contentView)
        
        contentView.addSubview(stackView)
    }
    
    func setConstraints() {
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(16)
            make.centerX.top.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.trailing.leading.equalToSuperview()
        }
        
        genderView.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.bottom)
            make.height.equalTo(75)
            make.trailing.leading.equalToSuperview()
        }
        
        studyView.snp.makeConstraints { make in
            make.top.equalTo(genderView.snp.bottom)
            make.height.equalTo(75)
            make.trailing.leading.equalToSuperview()
        }
        
        phoneView.snp.makeConstraints { make in
            make.top.equalTo(studyView.snp.bottom)
            make.height.equalTo(75)
            make.trailing.leading.equalToSuperview()
        }
        
        ageView.snp.makeConstraints { make in
            make.top.equalTo(phoneView.snp.bottom)
            make.height.equalTo(100)
            make.trailing.leading.equalToSuperview()
        }
        
        withdrawView.snp.makeConstraints { make in
            make.top.equalTo(ageView.snp.bottom)
            make.height.equalTo(75)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
