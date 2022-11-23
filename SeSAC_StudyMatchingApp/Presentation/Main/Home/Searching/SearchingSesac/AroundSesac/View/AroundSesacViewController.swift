//
//  AroundSesacViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/21.
//

import UIKit

import RxCocoa
import RxSwift

class AroundSesacViewController: BaseViewController {
    let mainView = SesacCardView()
    let disposeBag = DisposeBag()
    let viewModel = SearchedViewModel()
    let refreshControl = UIRefreshControl()
    var hiddenFlag: [Bool] = []
        
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureUI() {
        mainView.tableView.register(SesacCardTableViewCell.self, forCellReuseIdentifier: SesacCardTableViewCell.reuseIdentifier)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.refreshControl = refreshControl
        
        if let data = viewModel.searchedData, !data.fromQueueDB.isEmpty {
            mainView.setSearchUI(noSearched: false)
        } else {
            mainView.setSearchUI(noSearched: true)
        }
    }
    
    override func bindData() {
        mainView.noSearchView.reloadButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                print("reload")
                if vc.viewModel.lat != 0, vc.viewModel.long != 0 {
                    vc.viewModel.requsetSearchData(lat: vc.viewModel.lat, long: vc.viewModel.long) { response in
                        switch response {
                        case .success(let success):
                            print(success)
                            
                            vc.viewModel.searchedData = success
                            vc.configureUI()
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
        
        mainView.noSearchView.changeButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                print("change")
                vc.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.requsetSearchData(lat: vc.viewModel.lat, long: vc.viewModel.long) { response in
                    switch response {
                    case .success(let success):
                        print("success!!!")
                        vc.viewModel.searchedData = success
                    case .failure(let error):
                        print("error \(error)")
                    }
                }
                
                vc.mainView.tableView.reloadData()
                vc.refreshControl.endRefreshing()
            }
            .disposed(by: disposeBag)
    }
}

extension AroundSesacViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.searchedData?.fromQueueDB.count ?? 0
        hiddenFlag.append(contentsOf: Array<Bool>(repeating: true, count: count))
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SesacCardTableViewCell.reuseIdentifier, for: indexPath) as? SesacCardTableViewCell else { return UITableViewCell() }
        guard let data = viewModel.searchedData?.fromQueueDB[indexPath.row] else { return UITableViewCell() }
        cell.cardView.nicknameView.moreButton.tag = indexPath.row
        cell.cardView.nicknameView.nameLabel.text = data.nick
        cell.setImage(data.background, data.sesac)
        cell.setRequestButtonType(request: true)
        cell.cardView.titleView.isHidden = hiddenFlag[indexPath.row]
        cell.cardView.titleView.moreButton.tag = indexPath.row
        cell.cardView.titleView.moreButton.addTarget(self, action: #selector(moreButtonTapped(_ :)), for: .touchUpInside)
        cell.requsetButton.tag = indexPath.row
        cell.requsetButton.addTarget(self, action: #selector(requsetButtonTapped(_ :)), for: .touchUpInside)
        
        if hiddenFlag[indexPath.row] {
            cell.cardView.nicknameView.moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        } else {
            cell.cardView.nicknameView.moreButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }
        
        cell.cardView.titleView.setMoreButtonFromReview(data.reviews.count > 0 ? false : true)
        cell.setSesacTitleColor(data.reputation)
        cell.configureDataSource(studies: data.studylist)
        
        if data.reviews.count > 0 {
            cell.cardView.titleView.reviewLabel.text = data.reviews.first
            cell.cardView.titleView.reviewLabel.textColor = .black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        hiddenFlag[indexPath.row].toggle()
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    @objc func moreButtonTapped(_ button: UIButton) {
        let vc = ReviewTableViewController()
        guard let data = viewModel.searchedData?.fromQueueDB else { return }
        vc.reviews = data[button.tag].reviews
        transViewController(ViewController: vc, type: .push)
    }
    
    @objc func requsetButtonTapped(_ button: UIButton) {
        guard let data = viewModel.searchedData?.fromQueueDB[button.tag] else { return }
        let vc = RequestPopupViewController()
        
        vc.uid = data.uid
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
}
