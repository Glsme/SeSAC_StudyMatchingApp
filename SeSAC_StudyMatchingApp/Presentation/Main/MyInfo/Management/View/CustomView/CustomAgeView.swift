//
//  CustomAgeView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/15.
//

import UIKit

import MultiSlider

class CustomAgeView: BaseView {
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        return view
    }()
    
    lazy var ageSlider: MultiSlider = {
        let view = MultiSlider()
        view.thumbCount = 2
        view.minimumValue = 18
        view.maximumValue = 65
        view.outerTrackColor = .sesacGray2
        view.orientation = .horizontal
        view.tintColor = .sesacGreen
        view.showsThumbImageShadow = true
//        view.thumbTintColor = .sesacGreen
        view.thumbImage = UIImage(named: ManagementAssets.sliderImage.rawValue)

        return view
    }()
    
    lazy var ageLabel: UILabel = {
        let view = UILabel()
        view.textColor = .sesacGreen
        view.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
        view.text = "18 - 35"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [titleLabel, ageSlider, ageLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        ageSlider.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).multipliedBy(1.3)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.bottom.equalTo(ageSlider.snp.top)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
}
