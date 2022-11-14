//
//  ManagementTableViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import UIKit

class ManagementTableViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        return view
    }()
    
    lazy var manButton: GreenSlectedButton = {
        let view = GreenSlectedButton()
        view.setTitle("남자", for: .normal)
        return view
    }()
    
    lazy var womanButton: GreenSlectedButton = {
        let view = GreenSlectedButton()
        view.setTitle("여자", for: .normal)
        return view
    }()
    
    lazy var studyTextField: BlackHighlightTextField = {
        let view = BlackHighlightTextField()
        view.textField.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.setPlaceHolder("스터디를 입력해 주세요")
        view.textField.textAlignment = .left
        return view
    }()
    
    let permitSwitch: UISwitch = {
        let view = UISwitch()
        return view
    }()
    
    let ageSlider: UISlider = {
        let view = UISlider()
        return view
    }()
    
    let ageLabel: UILabel = {
        let view = UILabel()
        view.textColor = .sesacGreen
        view.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
//        selectionStyle = .none
        [titleLabel, manButton, womanButton, studyTextField, permitSwitch, ageSlider, ageLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setConstraints(index: Int) {
        switch index {
        case 0:
            print("hihi")
        case 1:
            setGenderConstraints()
        case 2:
            setUsuallyStudyConstraints()
        case 3:
            setPhonePermitConstraints()
        case 4:
            setAgeGroupConstraints()
        case 5:
            setDefaultConstraints()
        default:
            break
        }
    }
    
    func setDefaultConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading)
        }
        
        permitSwitch.isHidden = true
        ageSlider.isHidden = true
    }
    
    func setGenderConstraints() {
        setDefaultConstraints()
        
        womanButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(48)
            make.width.equalTo(56)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        manButton.snp.makeConstraints { make in
            make.trailing.equalTo(womanButton.snp.leading).offset(-8)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(womanButton.snp.height)
            make.width.equalTo(womanButton.snp.width)
        }
    }
    
    func setUsuallyStudyConstraints() {
        setDefaultConstraints()
        
        studyTextField.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalTo(self.snp.trailing)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.45)
            make.height.equalTo(40)
        }
    }
    
    func setPhonePermitConstraints() {
        setDefaultConstraints()
        permitSwitch.isHidden = false
        
        permitSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(28)
            make.width.equalTo(52)
            make.trailing.equalTo(self.snp.trailing)
        }
    }
    
    func setAgeGroupConstraints() {
        permitSwitch.isHidden = true
        ageSlider.isHidden = false
        
        ageSlider.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.bottom.equalTo(ageSlider.snp.top).offset(-20)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
}
