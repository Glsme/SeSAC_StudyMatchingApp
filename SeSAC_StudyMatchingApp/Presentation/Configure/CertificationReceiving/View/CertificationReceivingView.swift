//
//  CertificationReceivingView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

import SnapKit

final class CertificationReceivingView: UserConfigureView {
    lazy var certificationTextField: UITextField = {
        let view = UITextField()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.keyboardType = .numberPad
        return view
    }()
    
    lazy var line = TextFieldHighlightLine()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        super.configureUI()
        
        [certificationTextField, line].forEach {
            self.addSubview($0)
        }
        
        descriptionLabel.text = CertificationReceivingMents.description.rawValue
        certificationTextField.placeholder = CertificationReceivingMents.placeholder.rawValue
        requestButton.setTitle(CertificationReceivingMents.startButtonText.rawValue, for: .normal)
        requestButton.setEnabledButton(true)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        certificationTextField.snp.makeConstraints { make in
            make.width.equalTo(requestButton.snp.width)
            make.height.equalTo(40)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.75)
        }
        
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(certificationTextField.snp.bottom)
            make.leading.trailing.equalTo(certificationTextField)
        }
    }
}

