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
//        view.backgroundColor = .black
        return view
    }()
    
    let startButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: Assets.startButton.rawValue), for: .normal)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [onboardingCollectionView, startButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        onboardingCollectionView.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.7)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.88)
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
