//
//  ProfileNicknameView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/15.
//

import UIKit

import SnapKit

class ProfileNicknameView: BaseView {
    let nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 16)
        view.text = "닉네임"
        return view
    }()
    
    let moreButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        view.tintColor = .sesacGray7
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [nameLabel, moreButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalTo(self.snp.trailing)
            make.width.height.equalTo(16)
        }
    }
}
