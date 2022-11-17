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
    
    lazy var searchBar: UISearchBar = {
        let width = UIScreen.main.bounds.width
        let view = UISearchBar(frame: CGRect(x: 0, y: 0, width: width - 20, height: 0))
        view.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        return view
    }()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        configureDataSource()
    }
    
    override func configureUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
//        mainView.collectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchHeaderView")
        mainView.collectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.reuseIdentifier)
    }
    
    override func bindData() {
        searchBar.rx.searchButtonClicked
            .withUnretained(self)
            .bind { (vc, _) in
                guard let text = vc.searchBar.text else { return }
                
                guard vc.viewModel.checkOverlappingStudyName(text) else {
                    vc.view.makeToast("이미 하고 싶은 스터디에 '\(text)'이(가) 있습니다.", position: .center)
                    return
                }
                
                guard vc.viewModel.myHopeStudies.count <= 7 else {
                    vc.view.makeToast("스터디를 더 이상 추가할 수 없습니다", position: .center)
                    return
                }
                
                var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
                snapshot.appendSections([0, 1])
        //        snapshot.appendItems(viewModel.tagTitle, toSection: 0)
                vc.viewModel.myHopeStudies.append(text)
                snapshot.appendItems(vc.viewModel.myHopeStudies, toSection: 1)
                vc.dataSource.apply(snapshot, animatingDifferences: false)
            }
            .disposed(by: disposeBag)
    }
}

extension SearchViewController {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<TagCell, String> { cell, indexPath, itemIdentifier in
            cell.titleLabel.text = itemIdentifier
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) { [weak self] headerView, elementKind, indexPath in
            guard let self = self else { return }
            
            var configuration = headerView.defaultContentConfiguration()
            configuration.text = self.viewModel.titleArray[indexPath.section]
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
        snapshot.appendSections([0, 1])
//        snapshot.appendItems(viewModel.tagTitle, toSection: 0)
        snapshot.appendItems(viewModel.myHopeStudies, toSection: 1)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
