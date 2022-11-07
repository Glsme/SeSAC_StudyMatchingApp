//
//  CertificationView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

final class CertificationView: BaseView {
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 20)
        view.textAlignment = .center
        view.text = CertificationMents.description.rawValue
        view.numberOfLines = 2
        return view
    }()
    
    lazy var certificationTextField: UITextField = {
        let view = UITextField()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.placeholder = CertificationMents.placeholder.rawValue
        view.keyboardType = .numberPad
        return view
    }()
    
    lazy var requestButton: GreenBgButton = {
        let view = GreenBgButton()
        view.setTitle(CertificationMents.buttonText.rawValue, for: .normal)
        view.titleLabel?.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.setEnabledButton(false)
        return view
    }()
    
    lazy var line = BlackLine()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [descriptionLabel, certificationTextField, requestButton, line].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
            make.height.lessThanOrEqualTo(100)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.47)
            make.top.greaterThanOrEqualTo(safeAreaLayoutGuide.snp.top)
        }
        
        certificationTextField.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.85)
            make.height.equalTo(40)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.78)
        }
        
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(certificationTextField.snp.bottom)
            make.leading.trailing.equalTo(certificationTextField)
        }
        
        requestButton.snp.makeConstraints { make in
            make.width.equalTo(certificationTextField.snp.width)
            make.height.equalTo(48)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(1.05)
        }
    }
}
