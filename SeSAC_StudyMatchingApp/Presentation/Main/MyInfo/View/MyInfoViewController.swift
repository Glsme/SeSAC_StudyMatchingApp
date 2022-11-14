//
//  MyInfoViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import UIKit

import RxDataSources
import RxSwift

class MyInfoViewController: BaseViewController {
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
    }
    
    override func bindData() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfMyInfoCell> { [weak self] dataSource, tableView, indexPath, item in
            guard let self = self else { return UITableViewCell() }
            guard let cell = self.mainView.myInfoTableView.dequeueReusableCell(withIdentifier: MyInfoTableViewCell.reuseIdentifier, for: indexPath) as? MyInfoTableViewCell else { return UITableViewCell() }
            cell.iconView.image = UIImage(named: item.image)
            cell.titleLabel.text = item.title

            return cell
        }
        
        let sections = [SectionOfMyInfoCell(header: "First section", items: viewModel.cellDatas)]
        
        Observable.just(sections)
            .bind(to: mainView.myInfoTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
