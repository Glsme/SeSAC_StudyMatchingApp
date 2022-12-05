//
//  BackgroundCollectionViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/12/05.
//

import UIKit

import SnapKit
import RxCocoa
import RxSwift

class BackgroundCollectionViewCell: UICollectionViewCell {
    var cellDisposebag = DisposeBag()
    
    lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.sesacGray2.cgColor
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
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
    
    lazy var buyButton: GreenBgButton = {
        let view = GreenBgButton()
        view.clipsToBounds = true
        view.titleLabel?.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 12)
        view.layer.cornerRadius = 10
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
        [backgroundImageView, titleLabel, descriptionLabel, buyButton].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(16)
            make.height.equalTo(backgroundImageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundImageView).multipliedBy(0.9)
            make.leading.equalTo(backgroundImageView.snp.trailing).offset(12)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        
        buyButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
            make.width.equalTo(52)
        }
    }
    
    override func prepareForReuse() {
        self.cellDisposebag = DisposeBag()
    }
}
