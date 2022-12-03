//
//  CharacterCollectionViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/12/03.
//

import UIKit

import SnapKit

class CharacterCollectionViewCell: UICollectionViewCell {
    lazy var characterImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.sesacGray2.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 16)
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [characterImageView, titleLabel, descriptionLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints() {
        characterImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview().inset(16)
            make.height.equalTo(characterImageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(characterImageView)
            make.top.equalTo(characterImageView.snp.bottom).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.trailing.leading.equalTo(characterImageView)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
}
