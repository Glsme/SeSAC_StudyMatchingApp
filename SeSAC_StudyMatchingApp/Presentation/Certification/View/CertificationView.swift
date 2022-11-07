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
        view.text = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해주세요"
        view.numberOfLines = 2
        return view
    }()
    
    lazy var certificationTextField: UITextField = {
        let view = UITextField()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        return view
    }()
    
    lazy var requestButton: UIButton = {
        let view = UIButton()
        view.setTitle("인증 문자 받기", for: .normal)
        view.titleLabel?.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.setTitleColor(.sesacGray3, for: .normal)
        view.backgroundColor = .sesacGray6
        view.layer.cornerRadius = 8
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [descriptionLabel, certificationTextField, requestButton].forEach {
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
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.75)
        }
        
        requestButton.snp.makeConstraints { make in
            make.width.equalTo(certificationTextField.snp.width)
            make.height.equalTo(48)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(1.05)
        }
    }
}
