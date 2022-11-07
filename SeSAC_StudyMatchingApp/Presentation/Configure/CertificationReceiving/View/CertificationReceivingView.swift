//
//  CertificationReceivingView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

import SnapKit

class CertificationReceivingView: UserConfigureView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        super.configureUI()
        
        descriptionLabel.text = CertificationReceivingMents.description.rawValue
        certificationTextField.placeholder = CertificationReceivingMents.placeholder.rawValue
        requestButton.setTitle(CertificationReceivingMents.startButtonText.rawValue, for: .normal)
        requestButton.setEnabledButton(true)
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
}

