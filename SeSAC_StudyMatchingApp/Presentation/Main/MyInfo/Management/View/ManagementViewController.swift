//
//  ManagementViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import UIKit

import RxDataSources
import RxSwift

class ManagementViewController: BaseViewController {
    let mainView = ManagementView()
    let viewModel = ManagementViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        mainView.managementTableView.register(ManagementTableViewCell.self, forCellReuseIdentifier: ManagementTableViewCell.reuseIdentifier)
    }
    
    override func bindData() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: { dataSource, tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ManagementTableViewCell.reuseIdentifier, for: indexPath) as? ManagementTableViewCell else { return UITableViewCell() }
            cell.setConstraints(index: indexPath.row)
            cell.titleLabel.text = item
            return cell
        })
        
        Observable.just([SectionModel(model: "first Section", items: ["", "내 성별", "자주하는 스터디", "내 번호 검색 허용", "상대방 연령대", "회원 탈퇴"])])
            .bind(to: mainView.managementTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        mainView.managementTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension ManagementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 200
        case 1, 2, 3, 5:
            return 75
        case 4:
            return 130
        default:
            return 0
        }
    }
}
