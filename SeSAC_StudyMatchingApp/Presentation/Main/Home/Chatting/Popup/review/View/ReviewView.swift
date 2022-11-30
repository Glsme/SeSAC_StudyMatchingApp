//
//  ReviewView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/30.
//

import UIKit

import SnapKit
import RxCocoa
import RxSwift

class ReviewView: BaseView {
    lazy var popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
        view.text = "리뷰 등록"
        return view
    }()
    
    lazy var subTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.text = "고래밥님과의 스터디는 어떠셨나요?"
        view.textColor = .sesacGreen
        return view
    }()
    
    lazy var reviewButton: GreenBgButton = {
        let view = GreenBgButton()
        view.setTitle("리뷰 등록하기", for: .normal)
        view.titleLabel?.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        return view
    }()
    
    let reviewTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .sesacGray1
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.layer.cornerRadius = 8
        return view
    }()
    
    let closeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.tintColor = .sesacGray6
        return view
    }()
    
    let firstButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("좋은 매너", for: .normal)
        return view
    }()
    
    let secondButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("빠른 응답", for: .normal)
        return view
    }()
    
    let thirdButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("능숙한 실력", for: .normal)
        return view
    }()
    
    let fourthButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("정확한 시간 약속", for: .normal)
        return view
    }()
    
    let fifthButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("친절한 성격", for: .normal)
        return view
    }()
    
    let sixthButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("유익한 시간", for: .normal)
        return view
    }()
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bindData()
    }
    
    override func configureUI() {
        self.addSubview(popupView)
        
        [reviewButton, reviewTextView, titleLabel, subTitleLabel, closeButton, firstButton, secondButton, thirdButton, fourthButton, fifthButton, sixthButton].forEach {
            popupView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        popupView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(16)
            make.center.equalTo(safeAreaLayoutGuide.snp.center)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.68)
        }
        
        reviewButton.snp.makeConstraints { make in
            make.bottom.trailing.leading.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        reviewTextView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(reviewButton)
            make.bottom.equalTo(reviewButton.snp.top).offset(-24)
            make.height.equalToSuperview().multipliedBy(0.35)
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
            make.trailing.equalTo(reviewTextView)
            make.top.equalTo(titleLabel)
            make.width.height.equalTo(14)
        }
        
        thirdButton.snp.makeConstraints { make in
            make.bottom.equalTo(reviewTextView.snp.top).offset(-24)
            make.height.equalTo(32)
            make.leading.equalToSuperview().inset(16)
            make.width.equalToSuperview().multipliedBy(0.43)
        }
        
        secondButton.snp.makeConstraints { make in
            make.bottom.equalTo(thirdButton.snp.top).offset(-8)
            make.width.leading.height.equalTo(thirdButton)
        }
        
        firstButton.snp.makeConstraints { make in
            make.bottom.equalTo(secondButton.snp.top).offset(-8)
            make.width.leading.height.equalTo(thirdButton)
        }
        
        sixthButton.snp.makeConstraints { make in
            make.width.height.bottom.equalTo(thirdButton)
            make.trailing.equalToSuperview().inset(16)
        }
        
        fifthButton.snp.makeConstraints { make in
            make.width.height.bottom.equalTo(secondButton)
            make.trailing.equalTo(sixthButton)
        }
        
        fourthButton.snp.makeConstraints { make in
            make.width.height.bottom.equalTo(firstButton)
            make.trailing.equalTo(sixthButton)
        }
    }
    
    func bindData() {
        firstButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.firstButton.setSelectedStyle(vc.checkButtonTapped(vc.firstButton))
                vc.reviewButton.setEnabledButton(vc.checkOtherButtonTabOrTextviewIsNotNil())
            }
            .disposed(by: disposeBag)
        
        secondButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.secondButton.setSelectedStyle(vc.checkButtonTapped(vc.secondButton))
                vc.reviewButton.setEnabledButton(vc.checkOtherButtonTabOrTextviewIsNotNil())
            }
            .disposed(by: disposeBag)
        
        thirdButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.thirdButton.setSelectedStyle(vc.checkButtonTapped(vc.thirdButton))
                vc.reviewButton.setEnabledButton(vc.checkOtherButtonTabOrTextviewIsNotNil())
            }
            .disposed(by: disposeBag)
        
        fourthButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.fourthButton.setSelectedStyle(vc.checkButtonTapped(vc.fourthButton))
                vc.reviewButton.setEnabledButton(vc.checkOtherButtonTabOrTextviewIsNotNil())
            }
            .disposed(by: disposeBag)
        
        fifthButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.fifthButton.setSelectedStyle(vc.checkButtonTapped(vc.fifthButton))
                vc.reviewButton.setEnabledButton(vc.checkOtherButtonTabOrTextviewIsNotNil())
            }
            .disposed(by: disposeBag)
        
        sixthButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.sixthButton.setSelectedStyle(vc.checkButtonTapped(vc.sixthButton))
                vc.reviewButton.setEnabledButton(vc.checkOtherButtonTabOrTextviewIsNotNil())
            }
            .disposed(by: disposeBag)
    }
    
    func checkButtonTapped(_ button: UIButton) -> Bool {
        if button.backgroundColor == .sesacGreen {
            return false
        } else {
            return true
        }
    }
    
    func checkOtherButtonTabOrTextviewIsNotNil() -> Bool {
        if firstButton.backgroundColor == .sesacGreen {
            return true
        }
        
        if secondButton.backgroundColor == .sesacGreen {
            return true
        }
        
        if thirdButton.backgroundColor == .sesacGreen {
            return true
        }
        
        if fourthButton.backgroundColor == .sesacGreen {
            return true
        }
        
        if fifthButton.backgroundColor == .sesacGreen {
            return true
        }
        
        if sixthButton.backgroundColor == .sesacGreen {
            return true
        }
        
        if reviewTextView.text != "" {
            return true
        }
        
        return false
    }
}
