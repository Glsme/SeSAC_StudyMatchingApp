//
//  CertificationView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

class CertificationRequsetView: UserConfigureView {
    lazy var phoneNumberTextField: BlackHighlightTextField = {
        let view = BlackHighlightTextField()
        view.setStyle(font: UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14), keyboardType: .numberPad)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        super.configureUI()
        
        self.addSubview(phoneNumberTextField)
        
        descriptionLabel.text = CertificationRequestMents.description.rawValue
        phoneNumberTextField.setPlaceHolder(CertificationRequestMents.placeholder.rawValue)
        requestButton.setTitle(CertificationRequestMents.buttonText.rawValue, for: .normal)
        requestButton.setEnabledButton(false)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.width.equalTo(requestButton.snp.width)
            make.height.equalTo(41) // TextField = 40, Line = 1
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.75)
        }
    }
}
