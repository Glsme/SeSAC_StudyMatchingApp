//
//  CertificationView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

class CertificationView: UserConfigureView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureUI() {
        [descriptionLabel, requestButton, line, certificationTextField].forEach {
            self.addSubview($0)
        }
        
        descriptionLabel.text = CertificationMents.description.rawValue
        certificationTextField.placeholder = CertificationMents.placeholder.rawValue
        requestButton.setTitle(CertificationMents.buttonText.rawValue, for: .normal)
        requestButton.setEnabledButton(false)
    }
}
