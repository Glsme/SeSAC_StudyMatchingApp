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
                guard let text = vc.searchBar.text else {
                    vc.mainView.makeToast("스터디를 입력해주세요", position: .center)
                    return
                }
                
                if text == " " || text.contains("  ") {
                    vc.mainView.makeToast("띄어쓰기를 주의해서 입력해주세요", position: .center)
                    return
                }
                
                guard vc.viewModel.checkOverlappingStudyName(text) else {
                    vc.view.makeToast("이미 등록된 스터디입니다.", position: .center)
                    return
                }
                
                let input = text.components(separatedBy: " ")
                let studyCount = vc.viewModel.myHopeStudies.count
                
                guard studyCount <= 7, studyCount + input.count <= 7 else {
                    vc.view.makeToast("스터디를 더 이상 추가할 수 없습니다", position: .center)
                    return
                }
                
                guard input.count == Set(input).count else {
                    vc.view.makeToast("입력한 스터디 중 중복된 이름이 있습니다.", position: .center)
                    return
                }
                
                guard input.count == input.filter({ $0.count <= 8 }).count else {
                    vc.view.makeToast("8자 이내로 입력해주세요", position: .center)
                    return
                }
                
                input.forEach {
                    vc.viewModel.myHopeStudies.append($0)
                }
                
                var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
                snapshot.appendSections([0, 1])
                snapshot.appendItems(vc.viewModel.recommandData, toSection: 0)
                snapshot.appendItems(vc.viewModel.myHopeStudies, toSection: 1)
                vc.dataSource.apply(snapshot, animatingDifferences: false)
            }
            .disposed(by: disposeBag)
        
        mainView.collectionView.rx.itemSelected
            .withUnretained(self)
            .bind { (vc, value) in
                if value.section == 0 {
                    
                } else if value.section == 1 {
                    var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
                    snapshot.appendSections([0, 1])
                    vc.viewModel.myHopeStudies.remove(at: value.item)
                    snapshot.appendItems(vc.viewModel.recommandData, toSection: 0)
                    snapshot.appendItems(vc.viewModel.myHopeStudies, toSection: 1)
                    vc.dataSource.apply(snapshot, animatingDifferences: false)
                }
            }
            .disposed(by: disposeBag)
    }
}

extension SearchViewController {
    func configureDataSource() {
        let tagCellRegistration = UICollectionView.CellRegistration<TagCell, String> { cell, indexPath, itemIdentifier in
            
            cell.titleLabel.text = itemIdentifier
        }
        
        let recommandCellRegistration = UICollectionView.CellRegistration<RecommandCell, String> { cell, indexPath, itemIdentifier in
            if indexPath.item <= self.viewModel.recommandData.count - 1 {
                cell.setMostStyle()
            }
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
            if indexPath.section == 0 {
                let cell = collectionView.dequeueConfiguredReusableCell(using: recommandCellRegistration, for: indexPath, item: itemIdentifier)
                
                return cell
            } else {
                let cell = collectionView.dequeueConfiguredReusableCell(using: tagCellRegistration, for: indexPath, item: itemIdentifier)
                
                return cell
            }
        })
        
        dataSource.supplementaryViewProvider = { [weak self] (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            return self?.mainView.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0, 1])
        snapshot.appendItems(viewModel.recommandData, toSection: 0)
        snapshot.appendItems(viewModel.myHopeStudies, toSection: 1)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
