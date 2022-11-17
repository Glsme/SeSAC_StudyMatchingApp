//
//  SearchViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/16.
//

import UIKit

import RxCocoa
import RxGesture
import RxSwift
 
class SearchViewController: BaseViewController {
    let mainView = SearchView()
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        configureDataSource()
    }
    
    override func configureUI() {
        setupSearchController()
//        mainView.collectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchHeaderView")
        mainView.collectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.reuseIdentifier)
    }
    
    func setupSearchController() {
        let screen = UIScreen.main.bounds
        let width = screen.width
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width - 20, height: 0))
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
    
    override func bindData() {
        
    }
    
}

extension SearchViewController {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<TagCell, String> { cell, indexPath, itemIdentifier in
            cell.tagButton.setTitle("셀안에 들어갈꺼~!", for: .normal)
            cell.tagButton.titleLabel?.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) { headerView, elementKind, indexPath in
            
            var configuration = headerView.defaultContentConfiguration()
            configuration.text = "지금 주변에는"
            configuration.textProperties.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 12) ?? UIFont.systemFont(ofSize: 12)
            configuration.textProperties.color = .black
            headerView.contentConfiguration = configuration
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { [weak self] (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            return self?.mainView.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.tagTitle)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
