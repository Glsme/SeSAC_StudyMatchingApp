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
        view.backgroundColor = .black
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
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.65)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.9)
        }
    }
    
    static func onboardingCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = (UIScreen.main.bounds.width * 0.95) - (spacing * 5)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width / 6, height: width / 6)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = 0
        
        return layout
    }
}
