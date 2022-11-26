//
//  ChattingViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/23.
//

import UIKit

import RxCocoa
import RxDataSources
import RxGesture
import RxKeyboard
import RxSwift

class ChattingViewController: BaseViewController {
    let mainView = ChatView()
    let viewModel = ChattingViewModel()
    let disposeBag = DisposeBag()
    let backButton = UIBarButtonItem(image: UIImage(named: CommonAssets.backButton.rawValue), style: .done, target: ChattingViewController.self, action: nil)
    let moreButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .done, target: ChattingViewController.self, action: nil)
    
    var moreButtonToggle: Bool = true
    lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionOfMessageCell> { [weak self] dataSource, tableView, indexPath, item in
        guard let self = self else { return UITableViewCell() }
        
        if indexPath.row == 0 {
            guard let cell = self.mainView.chatTableView.dequeueReusableCell(withIdentifier: DateTableViewCell.reuseIdentifier, for: indexPath) as? DateTableViewCell else { return UITableViewCell() }

            guard let date = item.message.createdAt.toDate() else { return UITableViewCell() }
            cell.dateLabel.text = self.viewModel.dateFormatter.string(from: date)
            if indexPath.section == 0 {
                if let data = self.viewModel.data {
                    cell.matchedTitleLabel.text = "\(data.matchedNick ?? "새싹")님과 매칭되었습니다."
                }
                
                cell.setFirstMatched(true)
            }
            
            return cell
        } else {
            if let myUid = UserManager.myUid, item.message.from == myUid {
                guard let cell = self.mainView.chatTableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.reuseIdentifier) as? MyChatTableViewCell else { return UITableViewCell() }
                
                cell.talkLabel.text = item.message.chat
                cell.timeLabel.text = "11:36"
                
                return cell
            } else {
                guard let cell = self.mainView.chatTableView.dequeueReusableCell(withIdentifier: YourChatTableViewCell.reuseIdentifier) as? YourChatTableViewCell else { return UITableViewCell() }
                
                cell.talkLabel.text = item.message.chat
                cell.timeLabel.text = "11:36"
                
                return cell
            }
        }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchChats()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        SocketIOManager.shared.closeConnection()
    }
    
    override func configureUI() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = moreButton
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = .white
        
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        guard let data = viewModel.data else { return }
        setNavigationTitle(data.matchedNick ?? "새싹")
    }
    
    override func bindData() {
        viewModel.chat
            .bind(to: mainView.chatTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        moreButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                print("tap moreButton, \(vc.moreButtonToggle)")
                
                if vc.moreButtonToggle {
                    vc.mainView.topBGView.isHidden = vc.moreButtonToggle
                    
                    vc.mainView.topButtonStackView.snp.updateConstraints { make in
                        make.bottom.equalTo(vc.view.safeAreaLayoutGuide.snp.top)
                    }
//
//                    UIView.animate(withDuration: 0.3) {
//                        vc.view.layoutIfNeeded()
//                    }
                } else {
                    vc.mainView.topBGView.isHidden = vc.moreButtonToggle
                    
                    vc.mainView.topButtonStackView.snp.updateConstraints { make in
                        make.bottom.equalTo(vc.view.safeAreaLayoutGuide.snp.top).offset(72)
                    }
                    
                    UIView.animate(withDuration: 0.3) {
                        vc.view.layoutIfNeeded()
                    }
                }
                
                vc.moreButtonToggle.toggle()
            }
            .disposed(by: disposeBag)
        
        mainView.topBGView.rx.tapGesture()
            .withUnretained(self)
            .subscribe { (vc, _) in
                if vc.moreButtonToggle {
                    vc.mainView.topBGView.isHidden = vc.moreButtonToggle
                    
                    vc.mainView.topButtonStackView.snp.updateConstraints { make in
                        make.bottom.equalTo(vc.view.safeAreaLayoutGuide.snp.top)
                    }
                }
                
                vc.moreButtonToggle.toggle()
            }
            .disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .skip(1)
            .drive(onNext: { height in
                self.mainView.setButtonisSendMode(true)
                
                let window = UIApplication.shared.windows.first
                let extra = window!.safeAreaInsets.bottom
                
                self.mainView.userInputView.snp.updateConstraints { make in
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(height - extra + 16)
                }
                
//                self.mainView.chatTableView.snp.updateConstraints { make in
//                    make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(height - extra)
//                }
                
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
                
            })
            .disposed(by: disposeBag)
        
        mainView.chatTableView.rx.didScroll
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .subscribe(onNext: { (vc, _) in
                vc.view.endEditing(false)
                vc.mainView.setButtonisSendMode(false)
                
                vc.mainView.userInputView.snp.updateConstraints { make in
                    make.bottom.equalTo(vc.view.safeAreaLayoutGuide).inset(16)
                }
                
//                vc.mainView.chatTableView.snp.updateConstraints { make in
//                    make.bottom.equalTo(vc.mainView.userInputView.snp.top).inset(16)
//                }
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
        
        mainView.reportButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.postChat("재용 하이")
            }
            .disposed(by: disposeBag)
    }
}
