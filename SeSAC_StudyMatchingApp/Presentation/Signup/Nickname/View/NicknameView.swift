//
//  NicknameView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import UIKit

final class NicknameView: UserConfigureView {
    lazy var nicknameTextField: BlackHighlightTextField = {
        let view = BlackHighlightTextField()
        view.setPlaceHolder(SignupMents.nicknamePlaceholder.rawValue)
        view.setStyle(font: UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14), keyboardType: .default)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        super.configureUI()
        
        self.addSubview(nicknameTextField)
        
        requestButton.setTitle(SignupMents.nextButton.rawValue, for: .normal)
        descriptionLabel.text = SignupMents.nicknameDescription.rawValue
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        nicknameTextField.snp.makeConstraints { make in
            make.width.equalTo(requestButton.snp.width)
            make.height.equalTo(41) // TextField = 40, Line = 1
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.75)
        }
    }
}
