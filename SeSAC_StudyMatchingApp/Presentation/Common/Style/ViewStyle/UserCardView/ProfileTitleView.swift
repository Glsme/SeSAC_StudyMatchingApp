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
    
    lazy var studyCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createTagLayout())
        view.showsVerticalScrollIndicator = false
        view.register(RecommendCell.self, forCellWithReuseIdentifier: RecommendCell.reuseIdentifier)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    lazy var moreButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        view.tintColor = .sesacGray7
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [titleLabel, firstButton, secondButton, thirdButton, fourthButton, fifthButton, sixthButton, studyCollectionView, sesacReviewLabel, reviewLabel, moreButton].forEach {
            self.addSubview($0)
        }
        
        studyCollectionView.isHidden = true
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
        
        studyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sixthButton.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview()
//            make.height.greaterThanOrEqualTo(90)
        }

        sesacReviewLabel.snp.makeConstraints { make in
            make.top.equalTo(studyCollectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalTo(moreButton.snp.leading)
        }

        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(sesacReviewLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(sesacReviewLabel.snp.centerY)
            make.trailing.equalToSuperview()
            make.height.width.equalTo(16)
        }
    }
    
    func setMoreButtonFromReview(_ noReview: Bool) {
        moreButton.isHidden = noReview
    }
    
    private func createTagLayout() -> UICollectionViewLayout {
        let size = NSCollectionLayoutSize(widthDimension: .estimated(60), heightDimension: .absolute(35))
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(35))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
        
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = config
        
        return layout
    }
}
