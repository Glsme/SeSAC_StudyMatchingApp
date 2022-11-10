//
//  EmailView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import UIKit

class EmailView: UserConfigureView {
    lazy var emailTextField: BlackHighlightTextField = {
        let view = BlackHighlightTextField()
        view.setPlaceHolder(SignupMents.emailPlaceHolder.rawValue)
        view.setStyle(font: UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14), keyboardType: .emailAddress)
        return view
    }()
    
    lazy var emailLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 16)
        view.textColor = .sesacGray7
        view.textAlignment = .center
        view.text = SignupMents.emailSubDescription.rawValue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        super.configureUI()
        
        [emailTextField, emailLabel].forEach {
            self.addSubview($0)
        }
        
        requestButton.setTitle(SignupMents.nextButton.rawValue, for: .normal)
        descriptionLabel.text = SignupMents.emailMainDescription.rawValue
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        emailTextField.snp.makeConstraints { make in
            make.width.equalTo(requestButton.snp.width)
            make.height.equalTo(41) // TextField = 40, Line = 1
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.75)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
        }
    }
}
