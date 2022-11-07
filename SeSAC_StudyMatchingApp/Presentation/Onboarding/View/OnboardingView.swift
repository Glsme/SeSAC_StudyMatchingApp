//
//  OnboardingView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

import SnapKit

final class OnboardingView: BaseView {
    let onboardingCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: onboardingCollectionViewLayout())
        view.showsHorizontalScrollIndicator = false
        view.decelerationRate = .fast
        view.isPagingEnabled = true
        return view
    }()
    
    let startButton: UIButton = {
        let view = UIButton()
        view.setTitle("시작하기", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .sesacGreen
        view.layer.cornerRadius = 8
        return view
    }()
    
    let pageControl: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = 3
        view.pageIndicatorTintColor = .lightGray
        view.currentPageIndicatorTintColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [onboardingCollectionView, pageControl, startButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        onboardingCollectionView.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.72)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.88)
        }
        
        pageControl.snp.makeConstraints { make in
            make.height.equalTo(8)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalTo(startButton.snp.top).offset(-42)
        }
        
        startButton.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
            make.height.equalTo(48)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-18)
        }
    }
    
    static func onboardingCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width, height: height * 0.6)
        layout.minimumLineSpacing = 0
        
        return layout
    }
}
