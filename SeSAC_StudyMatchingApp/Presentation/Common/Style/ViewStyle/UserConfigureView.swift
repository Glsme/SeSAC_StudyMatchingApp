//
//  UserConfigureView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

public class UserConfigureView: BaseView {
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 20)
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()
    
    lazy var certificationTextField: UITextField = {
        let view = UITextField()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.keyboardType = .numberPad
        return view
    }()
    
    lazy var requestButton: GreenBgButton = {
        let view = GreenBgButton()
        view.titleLabel?.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.setEnabledButton(false)
        return view
    }()
    
    lazy var line = BlackLine()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override func setConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
            make.height.lessThanOrEqualTo(100)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).multipliedBy(1.8)
            make.bottom.lessThanOrEqualTo(certificationTextField.snp.top)
        }
        
        certificationTextField.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.85)
            make.height.equalTo(40)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.75)
        }
        
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(certificationTextField.snp.bottom)
            make.leading.trailing.equalTo(certificationTextField)
        }
        
        requestButton.snp.makeConstraints { make in
            make.width.equalTo(certificationTextField.snp.width)
            make.height.equalTo(48)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(1.02)
        }
    }
}
