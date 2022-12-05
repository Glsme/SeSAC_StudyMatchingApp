//
//  BackgroundView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/12/05.
//

import UIKit

class BackgroundView: BaseView {
    lazy var backgroundCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        view.register(BackgroundCollectionViewCell.self, forCellWithReuseIdentifier: BackgroundCollectionViewCell.reuseIdentifier)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        self.addSubview(backgroundCollectionView)
    }
    
    override func setConstraints() {
        backgroundCollectionView.snp.makeConstraints { make in
            make.trailing.bottom.leading.equalToSuperview()
            make.top.equalToSuperview().offset(44)
        }
    }
    
    func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
//        let spacing: CGFloat = 16
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: height * 0.25)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        return layout
    }
}
