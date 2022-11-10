//
//  GenderView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import UIKit

class GenderView: UserConfigureView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        super.configureUI()
        
        descriptionLabel.text = SignupMents.genderMainDescription.rawValue
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
    }
}

