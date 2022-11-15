//
//  ManagementViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import UIKit

import SnapKit
import RxDataSources
import RxSwift

class ManagementViewController: BaseViewController {
    let mainView = ManagementView()
    let viewModel = ManagementViewModel()
    let disposeBag = DisposeBag()
//    var cardFlag: Bool = true
//    var cardViewHeight: CGFloat = 0
        
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
//        mainView.managementTableView.register(ManagementTableViewCell.self, forCellReuseIdentifier: ManagementTableViewCell.reuseIdentifier)
//        mainView.managementTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.reuseIdentifier)
//        mainView.managementTableView.estimatedRowHeight = 100
//        mainView.managementTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func bindData() {
//        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfManagementCell>(configureCell: { dataSource, tableView, indexPath, item in
//            if indexPath.section == 0 {
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseIdentifier, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
//                cell.userCardView.redView.isHidden = self.cardFlag
//                self.cardViewHeight = cell.userCardView.redView.frame.height
//                print(cell.frame.height, cell.userCardView.frame.height, cell.userCardView.redView.frame.height)
//
//                return cell
//            } else {
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: ManagementTableViewCell.reuseIdentifier, for: indexPath) as? ManagementTableViewCell else { return UITableViewCell() }
//
//                return cell
//            }
//        })
//
//        let sections = [SectionOfManagementCell(header: "1", items: [ManagementCell(title: nil)]),
//                        SectionOfManagementCell(header: "2", items: [ManagementCell(title: nil)])]
//
//        Observable.just(sections)
//            .bind(to: mainView.managementTableView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
//
//        mainView.managementTableView.rx.setDelegate(self)
//            .disposed(by: disposeBag)
//
//        mainView.managementTableView.rx.itemSelected
//            .withUnretained(self)
//            .bind { (vc, value) in
//                if value.section == 0 {
//                    vc.cardFlag.toggle()
//                    print(vc.cardFlag)
//                    vc.mainView.managementTableView.reloadData()
////                    vc.mainView.managementTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
//                }
//            }
//            .disposed(by: disposeBag)
    }
}
//
//extension ManagementViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.section {
//        case 0:
//            return cardFlag ? 60 : cardViewHeight
//        case 1:
//            return 600
//        default:
//            return 0
//        }
//    }
//}
