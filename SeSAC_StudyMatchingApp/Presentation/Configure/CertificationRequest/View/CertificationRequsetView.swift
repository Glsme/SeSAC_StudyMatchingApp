//
//  CertificationView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

class CertificationRequsetView: UserConfigureView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureUI() {
        [descriptionLabel, requestButton, line, certificationTextField].forEach {
            self.addSubview($0)
        }
        
        descriptionLabel.text = CertificationRequestMents.description.rawValue
        certificationTextField.placeholder = CertificationRequestMents.placeholder.rawValue
        requestButton.setTitle(CertificationRequestMents.buttonText.rawValue, for: .normal)
        requestButton.setEnabledButton(false)
    }
}
