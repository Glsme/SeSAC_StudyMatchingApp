//
//  MyInfoViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import UIKit

import RxDataSources
import RxSwift

final class MyInfoViewController: BaseViewController {
    let mainView = MyInfoView()
    let viewModel = MyInfoViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.myInfoTableView.register(MyInfoTableViewCell.self, forCellReuseIdentifier: MyInfoTableViewCell.reuseIdentifier)
    }
    
    override func configureUI() {
        viewModel.setCellData()
        setNavigationTitle("내정보")
    }
    
    override func bindData() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfMyInfoCell> { [weak self] dataSource, tableView, indexPath, item in
            guard let self = self else { return UITableViewCell() }
            guard let cell = self.mainView.myInfoTableView.dequeueReusableCell(withIdentifier: MyInfoTableViewCell.reuseIdentifier, for: indexPath) as? MyInfoTableViewCell else { return UITableViewCell() }
            cell.iconView.image = UIImage(named: item.image)
            cell.titleLabel.text = item.title
            cell.setConstraints(index: indexPath.item)
            return cell
        }
        
        let sections = [SectionOfMyInfoCell(header: "First section", items: viewModel.cellDatas)]
        
        Observable.just(sections)
            .bind(to: mainView.myInfoTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        mainView.myInfoTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        mainView.myInfoTableView.rx.itemSelected
            .withUnretained(self)
            .bind(onNext: { (vc, indexPath) in
                switch indexPath.row {
                case 0:
                    vc.checkIDToken()
                case 1:
                    break
                case 2:
                    break
                case 3:
                    break
                case 4:
                    break
                case 5:
                    break
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func checkIDToken() {
        viewModel.loginSesacServer { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let success):
                // 로그인 성공!
                let result = success.toDomain()
                UserManager.sesac = result.sesac
                UserManager.nickname = result.nick
                
                let nextVC = ManagementViewController()
                nextVC.viewModel.userInfo.onNext(result)
                self.transViewController(ViewController: nextVC, type: .push)
            case .failure(let error):
                self.responseError(error.rawValue)
            }
        }
    }
    
    func responseError(_ errorCode: Int) {
        switch errorCode {
        case 401:
            print("파이어베이스 토큰 에러")
            viewModel.refreshAndRetryLogin { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success(let success):
                    let result = success.toDomain()
                    UserManager.sesac = result.sesac
                    UserManager.nickname = result.nick
                    
                    let nextVC = ManagementViewController()
                    nextVC.viewModel.userInfo.onNext(result)
                    self.transViewController(ViewController: nextVC, type: .push)
                case .failure(let failure):
                    print(failure)
                }
            }
        case 406:
            print("미가입 유저!!!!!")
        case 500:
            print("서버 에러")
        case 501:
            print("클라이언트 에러다~")
        default:
            print("대체 무엇을 잘못한거냐")
        }
    }
}

extension MyInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.item == 0 ? 96 : 75
    }
}
