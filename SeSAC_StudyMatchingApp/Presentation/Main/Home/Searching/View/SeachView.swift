//
//  SeachView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/16.
//

import UIKit

class SearchView: BaseView {
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createTagLayout())
        view.showsVerticalScrollIndicator = false
        view.register(TagCell.self, forCellWithReuseIdentifier: TagCell.reuseIdentifier)
        view.register(RecommandCell.self, forCellWithReuseIdentifier: RecommandCell.reuseIdentifier)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        self.addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(16)
            make.trailing.leading.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func createTagLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(80),
            heightDimension: .absolute(32)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(32)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item, item]
        )
        
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 30, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = config
        return layout
    }
}
