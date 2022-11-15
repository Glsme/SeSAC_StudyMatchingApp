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
    lazy var titleView = ProfileTitleView()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nicknameView, titleView])
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.backgroundColor = .brown
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.sesacGray2.cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        return view
    }()
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .blue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        nicknameView.backgroundColor = .white
        
        [backgroundImageView, profileImageView, stackView].forEach {
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
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.height.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.49)
            make.bottom.equalTo(backgroundImageView.snp.bottom)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        nicknameView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(60)
            make.trailing.leading.equalToSuperview()
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(nicknameView.snp.bottom)
            make.centerX.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
