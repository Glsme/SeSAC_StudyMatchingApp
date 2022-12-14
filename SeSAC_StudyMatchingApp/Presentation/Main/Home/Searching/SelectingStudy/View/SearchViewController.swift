//
//  SearchViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/16.
//

import UIKit

import RxCocoa
import RxSwift
import RxKeyboard

final class SearchViewController: BaseViewController {
    let mainView = SearchView()
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, StudyTag>!
    
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
        tabBarController?.tabBar.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        //        mainView.collectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchHeaderView")
        mainView.collectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.reuseIdentifier)
    }
    
    override func bindData() {
        RxKeyboard.instance.visibleHeight
            .skip(1)
            .drive(onNext: { height in
                let window = UIApplication.shared.windows.first
                let extra = window!.safeAreaInsets.bottom
                
                self.mainView.searchButton.layer.cornerRadius = 0
                self.mainView.searchButton.snp.updateConstraints { make in
                    make.trailing.leading.equalTo(self.view.safeAreaLayoutGuide)
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(height - extra)
                }
                
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
                
            })
            .disposed(by: disposeBag)
        
        mainView.collectionView.rx.didScroll
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .subscribe(onNext: { (vc, _) in
                vc.searchBar.endEditing(true)
                vc.mainView.searchButton.layer.cornerRadius = 8
                vc.mainView.searchButton.snp.updateConstraints { make in
                    make.trailing.leading.equalTo(vc.view.safeAreaLayoutGuide).inset(16)
                    make.bottom.equalTo(vc.view.safeAreaLayoutGuide).inset(16)
                }
                
                UIView.animate(withDuration: 0.2) {
                    vc.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
        
        
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
                    vc.viewModel.myHopeStudies.append(StudyTag(title: $0))
                }
                
                vc.updateSnapshot()
            }
            .disposed(by: disposeBag)
        
        mainView.collectionView.rx.itemSelected
            .withUnretained(self)
            .bind { (vc, value) in
                if value.section == 0 {
                    let data = StudyTag(title: vc.viewModel.recommandData[value.item].title)
                    if vc.viewModel.myHopeStudies.filter({ $0.title == data.title }).count > 0 {
                        vc.view.makeToast("이미 등록된 스터디입니다.", position: .center)
                    } else if vc.viewModel.myHopeStudies.count > 7 {
                        vc.view.makeToast("스터디를 더 이상 추가할 수 없습니다.", position: .center)
                    } else {
                        vc.viewModel.myHopeStudies.append(data)
                        vc.updateSnapshot()
                    }
                } else if value.section == 1 {
                    let data = StudyTag(title: vc.viewModel.fromQueueDB[value.item].title)
                    if vc.viewModel.myHopeStudies.filter({ $0.title == data.title }).count > 0 {
                        vc.view.makeToast("이미 등록된 스터디입니다.", position: .center)
                    } else if vc.viewModel.myHopeStudies.count > 7 {
                        vc.view.makeToast("스터디를 더 이상 추가할 수 없습니다.", position: .center)
                    } else {
                        vc.viewModel.myHopeStudies.append(data)
                        vc.updateSnapshot()
                    }
                } else if value.section == 2 {
                    vc.viewModel.myHopeStudies.remove(at: value.item)
                    
                    vc.updateSnapshot()
                }
            }
            .disposed(by: disposeBag)
        
        mainView.searchButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.requsetSearchSesac { statusCode in
                    guard let statusCode = SearchStatus(rawValue: statusCode) else { return }
                    switch statusCode {
                    case .success:
                        vc.viewModel.requsetSearchData(lat: vc.viewModel.lat, long: vc.viewModel.long) { response in
                            switch response {
                            case .success(let success):
                                let nextVC = SearchTabViewController()
                                nextVC.viewModel.searchData = success
                                nextVC.viewModel.lat = vc.viewModel.lat
                                nextVC.viewModel.long = vc.viewModel.long
                                vc.transViewController(ViewController: nextVC, type: .push)
                            case .failure(let error):
                                print("error: \(error)")
                            }
                        }
                    case .declaration:
                        vc.view.makeToast("신고가 누적되어 이용하실 수 없습니다.", position: .center)
                    case .delayOneMinute:
                        vc.view.makeToast("스터디 취소 패널티로, 1분동안 이용하실 수 없습니다.", position: .center)
                    case .delayTowMinute:
                        vc.view.makeToast("스터디 취소 패널티로, 2분동안 이용하실 수 없습니다.", position: .center)
                    case .delayThreeMinute:
                        vc.view.makeToast("스터디 취소 패널티로, 3분동안 이용하실 수 없습니다.", position: .center)
                    case .firebaseTokenError:
                        print("Firebase Token Error")
                    case .noSignupUser:
                        print("미가입 회원")
                    case .serverError:
                        print("serverError")
                    case .clientError:
                        print("Client Error")
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}

extension SearchViewController {
    private func configureDataSource() {
        let tagCellRegistration = UICollectionView.CellRegistration<TagCell, StudyTag> { cell, indexPath, itemIdentifier in
            cell.titleLabel.text = itemIdentifier.title
        }
        
        let recommandCellRegistration = UICollectionView.CellRegistration<RecommendCell, StudyTag> { cell, indexPath, itemIdentifier in
            if indexPath.section == 0 {
                cell.setMostStyle()
            }
            
            cell.titleLabel.text = itemIdentifier.title
            
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) { headerView, elementKind, indexPath in
            
            var configuration = headerView.defaultContentConfiguration()
            if indexPath.section == 0 {
                configuration.text = "지금 주변에는"
            } else if indexPath.section == 2 {
                configuration.text = "내가 하고 싶은"
            }
            //            configuration.text = indexPath.section == 0 ? "지금 주변에는" : "내가 하고 싶은"
            configuration.textProperties.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 12) ?? UIFont.systemFont(ofSize: 12)
            configuration.textProperties.color = .black
            headerView.contentConfiguration = configuration
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            if indexPath.section == 0 || indexPath.section == 1 {
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
        
        updateSnapshot()
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, StudyTag>()
        snapshot.appendSections([0, 1, 2])
        snapshot.appendItems(viewModel.recommandData, toSection: 0)
        snapshot.appendItems(viewModel.fromQueueDB, toSection: 1)
        snapshot.appendItems(viewModel.myHopeStudies, toSection: 2)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
