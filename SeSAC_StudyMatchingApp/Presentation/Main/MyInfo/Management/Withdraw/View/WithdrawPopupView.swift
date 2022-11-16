//
//  WithdrawPopupView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/16.
//

import UIKit

import SnapKit

class WithdrawPopupView: BaseView {
    lazy var popupView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .white
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "정말 탈퇴하시겠습니까?"
        view.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 16)
        view.textAlignment = .center
        return view
    }()
    
    lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.text = "탈퇴하시면 새싹 스터디를 이용할 수 없어요ㅠ"
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.textAlignment = .center
        return view
    }()
    
    lazy var cancelButton: UIButton = {
        let view = UIButton()
        view.setTitle("취소", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.backgroundColor = .sesacGray2
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    lazy var okButton: UIButton = {
        let view = UIButton()
        view.setTitle("확인", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.backgroundColor = .sesacGreen
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        self.addSubview(popupView)
        
        [titleLabel, subtitleLabel, cancelButton, okButton].forEach {
            popupView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        popupView.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.21)
        }
        
        okButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(16)
            make.width.equalToSuperview().multipliedBy(0.43)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(16)
            make.width.equalTo(okButton.snp.width)
            make.height.equalTo(okButton.snp.height)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.leading.trailing.equalToSuperview()
        }
    }
}
