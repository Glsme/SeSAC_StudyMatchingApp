//
//  ProfileTitleView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/15.
//

import UIKit

class ProfileTitleView: BaseView {
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 12)
        view.text = "새싹 타이틀"
        return view
    }()
    
    let firstButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("좋은 매너1", for: .normal)
        return view
    }()
    
    let secondButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("좋은 매너2", for: .normal)
        return view
    }()
    
    let thirdButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("좋은 매너3", for: .normal)
        return view
    }()
    
    let fourthButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("좋은 매너4", for: .normal)
        return view
    }()
    
    let fifthButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("좋은 매너5", for: .normal)
        return view
    }()
    
    let sixButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("좋은 매너6", for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [titleLabel, firstButton, secondButton, thirdButton, fourthButton, fifthButton, sixButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
        }
        
        firstButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(titleLabel.snp.leading)
            make.height.equalTo(32)
            make.width.equalTo(self.snp.width).multipliedBy(0.49)
        }
        
        secondButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(32)
            make.width.equalTo(self.snp.width).multipliedBy(0.49)
        }
        
        thirdButton.snp.makeConstraints { make in
            make.top.equalTo(firstButton.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.height.equalTo(32)
            make.width.equalTo(self.snp.width).multipliedBy(0.49)
        }
        
        fourthButton.snp.makeConstraints { make in
            make.top.equalTo(firstButton.snp.bottom).offset(8)
            make.trailing.equalTo(secondButton.snp.trailing)
            make.height.equalTo(32)
            make.width.equalTo(self.snp.width).multipliedBy(0.49)
        }
        
        fifthButton.snp.makeConstraints { make in
            make.top.equalTo(fourthButton.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.height.equalTo(32)
            make.width.equalTo(self.snp.width).multipliedBy(0.49)
        }
        
        sixButton.snp.makeConstraints { make in
            make.top.equalTo(fourthButton.snp.bottom).offset(8)
            make.trailing.equalTo(secondButton.snp.trailing)
            make.height.equalTo(32)
            make.width.equalTo(self.snp.width).multipliedBy(0.49)
        }
    }
}
