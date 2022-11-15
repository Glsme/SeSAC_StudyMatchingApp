//
//  ProfileCardView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/15.
//

import UIKit

import SnapKit

class ProfileCardView: BaseView {
//    lazy var backgroundImageView: UIImageView = {
//            let view = UIImageView()
//            view.backgroundColor = .brown
//            view.layer.cornerRadius = 8
//            view.clipsToBounds = true
//            return view
//        }()
//
//    lazy var profileImageView = UIImageView()
    
    lazy var nicknameView = ProfileNicknameView()
    
    lazy var titleView: ProfileTitleView = {
        let view = ProfileTitleView()
        view.backgroundColor = .brown
        return view
    }()
    
//    lazy var cardView: UIStackView = {
//        let view = UIStackView(arrangedSubviews: [nicknameView, titleView])
//        view.axis = .vertical
//        view.alignment = .fill
//        view.distribution = .fill
//        view.spacing = 12
//        view.backgroundColor = .red
//        return view
//    }()
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .blue
        return view
    }()
    
    //MARK: - Test Code
    lazy var redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
//        [nicknameView].forEach {
//            cardView.addSubview($0)
//        }
        
        //MARK: - Test Code
        cardView.addSubview(redView)
        
        [cardView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
//        nicknameView.snp.makeConstraints { make in
//            make.height.equalTo(60)
//            make.top.equalTo(self.snp.top)
//            make.trailing.equalTo(self.snp.trailing)
//            make.leading.equalTo(self.snp.leading)
//        }

//        titleView.snp.makeConstraints { make in
//            make.top.equalTo(nicknameView.snp.top)
//            make.trailing.equalTo(nicknameView.snp.trailing)
//            make.leading.equalTo(nicknameView.snp.leading)
//        }
        
//        backgroundImageView.snp.makeConstraints { make in
//            make.width.equalTo(self.snp.width)
//            make.height.equalTo(194)
//            make.centerX.equalTo(self.snp.centerX)
//            make.top.equalTo(self.snp.top)
//        }
        
        redView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.width.equalTo(30)
            make.height.equalTo(200)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.trailing.equalTo(self.snp.trailing)
            make.leading.equalTo(self.snp.leading)
            make.height.equalTo(redView.snp.height)
        }
    }
}
