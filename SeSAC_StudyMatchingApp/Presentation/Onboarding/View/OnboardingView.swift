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
//        view.backgroundColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [onboardingCollectionView].forEach {
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
    }
    
    static func onboardingCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width, height: height * 0.6)
        
        return layout
    }
}
