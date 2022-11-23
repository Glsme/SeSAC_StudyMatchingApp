//
//  ChattingViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/23.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift

class ChattingViewController: BaseViewController {
    let mainView = ChatView()
    let viewModel = ChattingViewModel()
    let disposeBag = DisposeBag()
    let backButton = UIBarButtonItem(image: UIImage(named: CommonAssets.backButton.rawValue), style: .done, target: ChattingViewController.self, action: nil)
    
    lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionOfMessageCell> { [weak self] dataSource, tableView, indexPath, item in
        guard let self = self else { return UITableViewCell() }
        guard let cell = self.mainView.chatTableView.dequeueReusableCell(withIdentifier: YourChatTableViewCell.reuseIdentifier) as? YourChatTableViewCell else { return UITableViewCell() }
        
        cell.talkLabel.text = item.message
        cell.timeLabel.text = "11:36"
        
        return cell
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureUI() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        guard let data = viewModel.data else { return }
        setNavigationTitle(data.matchedNick ?? "새싹")
    }
    
    override func bindData() {
        mainView.chatTableView.rx.didScroll
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .subscribe(onNext: { (vc, _) in
                vc.view.endEditing(false)
            })
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                guard let vcs = vc.navigationController?.viewControllers else { return }
                
                for vc in vcs {
                    if let rootVC = vc as? HomeViewController {
                        vc.navigationController?.popToViewController(rootVC, animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        Observable.just([
            SectionOfMessageCell(header: "hi", items: [MessageCell(message: "하이여"), MessageCell(message: "하이여\ndsafsdfasf\nasdfasdf")])
        ])
        .bind(to: mainView.chatTableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
    }
}