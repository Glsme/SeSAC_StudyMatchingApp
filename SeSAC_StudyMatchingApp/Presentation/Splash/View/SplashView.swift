//
//  SplashView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/11.
//

import UIKit

import SnapKit

final class SplashView: BaseView {
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "splash_logo")
        return view
    }()
    
    let labelImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "txt")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureUI() {
        [imageView, labelImageView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.82)
            make.width.equalToSuperview().multipliedBy(0.58)
            make.height.equalTo(imageView.snp.width).multipliedBy(1.19)
        }
        
        labelImageView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
            make.width.equalTo(imageView.snp.width).multipliedBy(1.34)
            make.height.equalTo(labelImageView.snp.width).multipliedBy(0.35)
        }
    }
}
