//
//  ProfileCardView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/15.
//

import UIKit

import SnapKit

class ProfileCardView: BaseView {
    lazy var backgroundImageView: UIImageView = {
            let view = UIImageView()
            view.backgroundColor = .brown
            view.layer.cornerRadius = 8
            view.clipsToBounds = true
            return view
        }()
        
    lazy var profileImageView = UIImageView()
    
    lazy var nicknameView = ProfileNicknameView()
    
    lazy var titleView: ProfileTitleView = {
        let view = ProfileTitleView()
        view.backgroundColor = .brown
        return view
    }()
    
    lazy var cardView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nicknameView, titleView])
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 12
        view.backgroundColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [backgroundImageView, profileImageView, cardView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width)
            make.height.equalTo(194)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top)
        }
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom)
            make.trailing.equalTo(backgroundImageView.snp.trailing)
            make.leading.equalTo(backgroundImageView.snp.leading)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
