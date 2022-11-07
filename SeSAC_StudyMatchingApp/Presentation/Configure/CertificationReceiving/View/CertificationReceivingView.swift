//
//  CertificationReceivingView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

class CertificationReceivingView: UserConfigureView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [descriptionLabel, requestButton, line, certificationTextField].forEach {
            self.addSubview($0)
        }
        
        descriptionLabel.text = CertificationReceivingMents.description.rawValue
        certificationTextField.placeholder = CertificationReceivingMents.placeholder.rawValue
        requestButton.setTitle(CertificationReceivingMents.startButtonText.rawValue, for: .normal)
        requestButton.setEnabledButton(true)
    }
}

