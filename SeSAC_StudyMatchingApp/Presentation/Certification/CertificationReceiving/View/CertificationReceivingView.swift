//
//  CertificationReceivingView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

import SnapKit

final class CertificationReceivingView: UserConfigureView {
    lazy var certificationTextField: BlackHighlightTextField = {
        let view = BlackHighlightTextField()
        view.setStyle(font: UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14), keyboardType: .numberPad)
        return view
    }()
    
    lazy var retryButton: GreenBgButton = {
        let view = GreenBgButton()
        view.setTitle(CertificationReceivingMents.reSendButtonText.rawValue, for: .normal)
        view.titleLabel?.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.setEnabledButton(true)
        return view
    }()
    
    lazy var timerLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
        view.textColor = .sesacGreen
        view.text = "01:00"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        super.configureUI()
        
        [certificationTextField, retryButton, timerLabel].forEach {
            self.addSubview($0)
        }
        
        descriptionLabel.text = CertificationReceivingMents.description.rawValue
        certificationTextField.setPlaceHolder(CertificationReceivingMents.placeholder.rawValue)
        requestButton.setTitle(CertificationReceivingMents.startButtonText.rawValue, for: .normal)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        certificationTextField.snp.makeConstraints { make in
            make.width.equalTo(requestButton.snp.width).multipliedBy(0.78)
            make.leading.equalTo(requestButton.snp.leading)
            make.height.equalTo(41) // TextField = 40, Line = 1
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.75)
        }
        
        retryButton.snp.makeConstraints { make in
            make.width.equalTo(requestButton.snp.width).multipliedBy(0.19)
            make.height.equalTo(40)
            make.trailing.equalTo(requestButton.snp.trailing)
            make.centerY.equalTo(certificationTextField.snp.centerY)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(certificationTextField.snp.centerY)
            make.trailing.equalTo(retryButton.snp.leading).offset(-20)
        }
    }
}

