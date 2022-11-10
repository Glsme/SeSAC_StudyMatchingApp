//
//  GenderView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import UIKit

import SnapKit

class GenderView: UserConfigureView {
    let manButton: UIButton = {
        let view = UIButton()
        view.layer.borderColor = UIColor.sesacGray4.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        
        var config = UIButton.Configuration.tinted()
        var titleAttr = AttributedString.init("남자")
        titleAttr.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 16)
        titleAttr.foregroundColor = .black
        config.attributedTitle = titleAttr
        
        config.image = UIImage(named: "man")
        config.imagePadding = 5
        config.imagePlacement = .top
        config.baseBackgroundColor = .white
        
        view.configuration = config
        view.backgroundColor = .white
        
        return view
    }()
    
    let womanButton: UIButton = {
        let view = UIButton()
        view.layer.borderColor = UIColor.sesacGray4.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        
        var config = UIButton.Configuration.tinted()
        var titleAttr = AttributedString.init("여자")
        titleAttr.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 16)
        titleAttr.foregroundColor = .black
        config.attributedTitle = titleAttr
        
        config.image = UIImage(named: "woman")
        config.imagePadding = 5
        config.imagePlacement = .top
        config.baseBackgroundColor = .white
        
        view.configuration = config
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var genderLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 16)
        view.textColor = .sesacGray7
        view.textAlignment = .center
        view.text = SignupMents.genderSubSDescription.rawValue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        super.configureUI()
        
        [genderLabel, manButton, womanButton].forEach {
            self.addSubview($0)
        }
        
        descriptionLabel.text = SignupMents.genderMainDescription.rawValue
        requestButton.setTitle(SignupMents.nextButton.rawValue, for: .normal)
        requestButton.setEnabledButton(true)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        genderLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
        }
        
        manButton.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.17)
            make.bottom.equalTo(requestButton.snp.top).offset(-30)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.41)
            make.leading.equalTo(requestButton.snp.leading)
        }
        
        womanButton.snp.makeConstraints { make in
            make.top.bottom.width.height.equalTo(manButton)
            make.trailing.equalTo(requestButton.snp.trailing)
        }
    }
}

