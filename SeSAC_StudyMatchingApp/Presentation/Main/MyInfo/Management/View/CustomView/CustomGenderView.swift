//
//  CustomGenderView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/15.
//

import UIKit

class CustomGenderView: BaseView {
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.text = "내 성별"
        return view
    }()
    
    lazy var manButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("남자", for: .normal)
        return view
    }()
    
    lazy var womanButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("여자", for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureUI() {
        [titleLabel, manButton, womanButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading)
        }
        
        womanButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(48)
            make.width.equalTo(56)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        manButton.snp.makeConstraints { make in
            make.trailing.equalTo(womanButton.snp.leading).offset(-8)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(womanButton.snp.height)
            make.width.equalTo(womanButton.snp.width)
        }
    }
}
