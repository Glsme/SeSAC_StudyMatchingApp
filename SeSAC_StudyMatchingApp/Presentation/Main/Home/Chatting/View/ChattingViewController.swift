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
            } else {
                cell.setFirstMatched(false)
            }
            
            return cell
        } else {
            if let myUid = UserManager.myUid, item.message.from == myUid {
                guard let cell = self.mainView.chatTableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.reuseIdentifier) as? MyChatTableViewCell else { return UITableViewCell() }
                
                cell.talkLabel.text = item.message.chat
                cell.setTimeText(item.message.createdAt)
                
                return cell
            } else {
                guard let cell = self.mainView.chatTableView.dequeueReusableCell(withIdentifier: YourChatTableViewCell.reuseIdentifier) as? YourChatTableViewCell else { return UITableViewCell() }
                
                cell.talkLabel.text = item.message.chat
                cell.setTimeText(item.message.createdAt)
                
                return cell
            }
        }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Realm URL
//        print("RealmURL: \(ChatRepository.shared.localRealm.configuration.fileURL!)")
        
        viewModel.fetchChats()
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage), name: NSNotification.Name("getMessage"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        SocketIOManager.shared.closeConnection()
    }
    
    @objc func getMessage(notification: NSNotification) {
        let chat = notification.userInfo!["chat"] as! String
        let createdAt = notification.userInfo!["createdAt"] as! String
        let id = notification.userInfo!["id"] as! String
        let to = notification.userInfo!["to"] as! String
        let from = notification.userInfo!["from"] as! String
        
        let value = Payload(id: id, to: to, from: from, chat: chat, createdAt: createdAt)
        
        viewModel.mychatData.payload.append(value)
        viewModel.inputChatData(data: viewModel.mychatData) { _, _ in }
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
//                print("tap moreButton, \(vc.moreButtonToggle)")
                vc.viewModel.requestMyQueueState { result in
//                    dump(result)
                    if result.dodged == 1 || result.reviewed == 1 {
                        vc.mainView.setMatchedButtonText(false)
                    } else if result.matched == 1 {
                        vc.mainView.setMatchedButtonText(true)
                    }
                }
                
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
                let reportVC = ReportViewController()
                reportVC.modalPresentationStyle = .currentContext
                vc.transViewController(ViewController: reportVC, type: .presentFullScreenWithoutAni)
            }
            .disposed(by: disposeBag)
        
        mainView.sendButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                guard let text = vc.mainView.inputTextView.text else { return }
                vc.viewModel.postChat(text) { [weak self] statusCode in
                    guard let self = self else { return }
                    if ChattingCode(rawValue: statusCode) == .success {
                        let date = self.viewModel.iso8601DateFormatter.string(from: Date())
                        
                        let value = Payload(id: "", to: self.viewModel.data?.matchedUid ?? "", from: UserManager.myUid ?? "", chat: text, createdAt: "\(date)")
                        
                        self.viewModel.mychatData.payload.append(value)
                        self.viewModel.inputChatData(data: self.viewModel.mychatData) { section, row in
//                            vc.mainView.chatTableView.scrollToRow(at: IndexPath(row: row, section: section), at: .bottom, animated: false)
                        }
                        
                        self.viewModel.savePostData(value)
                    } else {
                        vc.view.makeToast("전송에 실패했습니다.", position: .center)
                    }
                }
                
                vc.mainView.inputTextView.text = ""
                vc.mainView.setButtonisSendMode(false)
                vc.view.endEditing(true)
            }
            .disposed(by: disposeBag)
    }
}
