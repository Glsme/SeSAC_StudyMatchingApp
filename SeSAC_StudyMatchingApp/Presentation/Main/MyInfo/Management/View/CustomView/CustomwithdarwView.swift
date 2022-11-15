//
//  CustomwithdarwView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/15.
//

import UIKit

class CustomWithdrawView: BaseView {
    lazy var titleButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.text = "회원 탈퇴"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [titleLabel, titleButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        titleButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading)
        }
    }
}
