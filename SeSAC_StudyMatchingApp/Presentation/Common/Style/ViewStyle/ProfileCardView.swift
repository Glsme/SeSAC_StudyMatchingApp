//
//  ProfileCardView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/15.
//

import UIKit

import SnapKit

class ProfileCardView: BaseView {
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
        self.addSubview(cardView)
        
//        titleView.isHidden = true
    }
    
    override func setConstraints() {
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
