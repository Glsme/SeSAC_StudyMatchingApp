//
//  OnboardingCollectionViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

import SnapKit

class OnboardingCollectionViewCell: BaseCollectionViewCell {
    let descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 24)
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()
    
    let illustImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .black
    }
    
    override func configureUI() {
        [descriptionLabel, illustImageView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.bottom.lessThanOrEqualTo(illustImageView.snp.top)
        }
        
        illustImageView.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height).multipliedBy(0.75)
        }
    }
}
