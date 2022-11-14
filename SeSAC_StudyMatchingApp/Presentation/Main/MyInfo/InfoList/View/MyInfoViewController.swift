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
        navigationItem.title = "내정보"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14) ?? UIFont.systemFont(ofSize: 14)]
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
                    let nextVC = ManagementViewController()
                    vc.transViewController(ViewController: nextVC, type: .push)
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
}

extension MyInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.item == 0 ? 96 : 75
    }
}
