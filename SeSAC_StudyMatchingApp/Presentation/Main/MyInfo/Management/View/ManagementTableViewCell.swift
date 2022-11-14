//
//  ManagementTableViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import UIKit

import MultiSlider
import RxSwift

class ManagementTableViewCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
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
    
    let ageSlider: MultiSlider = {
        let view = MultiSlider()
        view.thumbCount = 2
        view.minimumValue = 18
        view.maximumValue = 65
        view.outerTrackColor = .sesacGray2
        view.orientation = .horizontal
        view.tintColor = .sesacGreen
        view.showsThumbImageShadow = true
//        view.thumbTintColor = .sesacGreen
        view.thumbImage = UIImage(named: ManagementAssets.sliderImage.rawValue)

        return view
    }()
    
    let ageLabel: UILabel = {
        let view = UILabel()
        view.textColor = .sesacGreen
        view.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
        return view
    }()
    
    let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .brown
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.sesacGray2.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let nicknameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 16)
        view.textAlignment = .left
        return view
    }()
    
    let moreButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "star.fill"), for: .normal)
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
        selectionStyle = .none
        [nicknameLabel, moreButton].forEach {
            contentView.addSubview($0)
        }
        [titleLabel, manButton, womanButton, studyTextField, permitSwitch, ageSlider, ageLabel, backgroundImageView, profileImageView, cardView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setConstraints(index: Int) {
        switch index {
        case 0:
            permitSwitch.isHidden = true
            ageSlider.isHidden = true
            
            profileImageView.image = UIImage(named: SesacCharaterAssets.sesacFace5.rawValue)
            backgroundImageView.image = UIImage(named: SesacBGAssets.sesacBG4.rawValue)
            
            backgroundImageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            profileImageView.snp.makeConstraints { make in
                make.centerX.equalTo(self.snp.centerX)
                make.bottom.equalTo(self.snp.bottom)
                make.width.height.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.45)
            }
        case 1:
            permitSwitch.isHidden = true
            ageSlider.isHidden = true
            
            cardView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            nicknameLabel.snp.makeConstraints { make in
                make.centerY.equalTo(self.snp.centerY)
                make.leading.equalTo(self.snp.leading).offset(10)
            }
            
            moreButton.snp.makeConstraints { make in
                make.centerY.equalTo(self.snp.centerY)
                make.trailing.equalTo(self.snp.trailing).offset(-10)
                make.width.height.equalTo(20)
            }
        case 2:
            setGenderConstraints()
        case 3:
            setUsuallyStudyConstraints()
        case 4:
            setPhonePermitConstraints()
        case 5:
            setAgeGroupConstraints()
        case 6:
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
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).multipliedBy(1.3)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.bottom.equalTo(ageSlider.snp.top)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
    
    func bindData() {
        manButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                if vc.womanButton.backgroundColor == .sesacGreen {
                    vc.manButton.setSelectedStyle(true)
                    vc.womanButton.setSelectedStyle(false)
                }
            }
            .disposed(by: disposeBag)
        
        womanButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                if vc.manButton.backgroundColor == .sesacGreen {
                    vc.womanButton.setSelectedStyle(true)
                    vc.manButton.setSelectedStyle(false)
                }
            }
            .disposed(by: disposeBag)
    }
}
