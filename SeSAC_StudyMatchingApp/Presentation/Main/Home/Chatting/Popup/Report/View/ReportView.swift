//
//  ReportView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/30.
//

import UIKit

import SnapKit

class ReportView: BaseView {
    lazy var popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
        view.text = "새싹 신고"
        return view
    }()
    
    let subTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.textColor = .sesacGreen
        view.text = "다시는 해당 새싹과 매칭되지 않습니다."
        return view
    }()
    
    let firstButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("불법/사기", for: .normal)
        return view
    }()
    
    let secondButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("불편한언행", for: .normal)
        return view
    }()
    
    let thirdButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("노쇼", for: .normal)
        return view
    }()
    
    let fourthButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("선정성", for: .normal)
        return view
    }()
    
    let fifthButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("인신공격", for: .normal)
        return view
    }()
    
    let sixthButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("기타", for: .normal)
        return view
    }()
    
    let reportTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .sesacGray1
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.layer.cornerRadius = 8
        return view
    }()
    
    let reportButton: GreenBgButton = {
        let view = GreenBgButton()
        view.setEnabledButton(false)
        view.setTitle("신고하기", for: .normal)
        return view
    }()
    
    let closeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.tintColor = .sesacGray6
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        self.addSubview(popupView)
        
        [titleLabel, subTitleLabel, firstButton, secondButton, thirdButton, fourthButton, fifthButton, sixthButton, reportTextView, reportButton, closeButton].forEach {
            popupView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        popupView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(16)
            make.center.equalTo(safeAreaLayoutGuide.snp.center)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.55)
        }
        
        reportButton.snp.makeConstraints { make in
            make.bottom.trailing.leading.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        reportTextView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(reportButton)
            make.bottom.equalTo(reportButton.snp.top).offset(-24)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        firstButton.snp.makeConstraints { make in
            make.leading.equalTo(reportButton)
            make.height.equalTo(36)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.bottom.equalTo(fourthButton.snp.top).offset(-8)
        }
        
        fourthButton.snp.makeConstraints { make in
            make.leading.equalTo(reportButton)
            make.width.equalTo(firstButton)
            make.height.equalTo(firstButton)
            make.bottom.equalTo(reportTextView.snp.top).offset(-28)
        }
        
        fifthButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(firstButton)
            make.height.equalTo(firstButton)
            make.bottom.equalTo(fourthButton.snp.bottom)
        }
        
        secondButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(firstButton)
            make.height.equalTo(firstButton)
            make.bottom.equalTo(firstButton.snp.bottom)
        }
        
        sixthButton.snp.makeConstraints { make in
            make.trailing.equalTo(reportTextView)
            make.bottom.equalTo(fourthButton.snp.bottom)
            make.width.equalTo(firstButton)
            make.height.equalTo(firstButton)
        }
        
        thirdButton.snp.makeConstraints { make in
            make.trailing.equalTo(sixthButton)
            make.bottom.equalTo(firstButton)
            make.height.equalTo(firstButton)
            make.width.equalTo(firstButton)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        closeButton.snp.makeConstraints { make in
            make.trailing.equalTo(reportTextView)
            make.top.equalTo(titleLabel)
            make.width.height.equalTo(14)
        }
    }
}
