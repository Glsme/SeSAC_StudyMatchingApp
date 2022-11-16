//
//  ProfileTitleView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/15.
//

import UIKit

class ProfileTitleView: BaseView {
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 12)
        view.text = "새싹 타이틀"
        return view
    }()
    
    let firstButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("좋은 매너", for: .normal)
        return view
    }()
    
    let secondButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("정확한 시간 약속", for: .normal)
        return view
    }()
    
    lazy var thirdButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("빠른 응답", for: .normal)
        return view
    }()

    lazy var fourthButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("친절한 성격", for: .normal)
        return view
    }()

    lazy var fifthButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("능숙한 실력", for: .normal)
        return view
    }()

    lazy var sixthButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setTitle("유익한 시간", for: .normal)
        return view
    }()

    lazy var sesacReviewLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 12)
        view.text = "새싹 리뷰"
        return view
    }()

    lazy var reviewLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.text = "첫 리뷰를 기다리는 중이에요"
        view.textColor = .sesacGray6
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [titleLabel, firstButton, secondButton, thirdButton, fourthButton, fifthButton, sixthButton, sesacReviewLabel, reviewLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }

        firstButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(titleLabel.snp.leading)
//            make.height.equalTo(32)
            make.width.equalTo(self.snp.width).multipliedBy(0.49)
        }

        secondButton.snp.makeConstraints { make in
            make.top.equalTo(firstButton.snp.top)
            make.trailing.equalTo(self.snp.trailing)
//            make.height.equalTo(32)
            make.width.equalTo(self.snp.width).multipliedBy(0.49)
        }

        thirdButton.snp.makeConstraints { make in
            make.top.equalTo(firstButton.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
//            make.height.equalTo(32)
            make.width.equalTo(self.snp.width).multipliedBy(0.49)
        }

        fourthButton.snp.makeConstraints { make in
            make.top.equalTo(firstButton.snp.bottom).offset(8)
            make.trailing.equalTo(secondButton.snp.trailing)
//            make.height.equalTo(32)
            make.width.equalTo(self.snp.width).multipliedBy(0.49)
        }

        fifthButton.snp.makeConstraints { make in
            make.top.equalTo(fourthButton.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
//            make.height.equalTo(32)
            make.width.equalTo(self.snp.width).multipliedBy(0.49)
        }

        sixthButton.snp.makeConstraints { make in
            make.top.equalTo(fourthButton.snp.bottom).offset(8)
            make.trailing.equalTo(secondButton.snp.trailing)
//            make.height.equalTo(32)
            make.width.equalTo(self.snp.width).multipliedBy(0.49)
        }

        sesacReviewLabel.snp.makeConstraints { make in
            make.top.equalTo(fifthButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }

        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacReviewLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
