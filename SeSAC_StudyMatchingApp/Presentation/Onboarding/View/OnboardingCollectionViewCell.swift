//
//  OnboardingCollectionViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

import SnapKit

class OnboardingCollectionViewCell: BaseCollectionViewCell {
    let descriptionImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .blue
        return view
    }()
    
    let illustImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .brown
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [descriptionImageView, illustImageView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        descriptionImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.height.equalTo(self.snp.height).multipliedBy(0.1)
        }
        
        illustImageView.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height).multipliedBy(0.7)
        }
    }
}
