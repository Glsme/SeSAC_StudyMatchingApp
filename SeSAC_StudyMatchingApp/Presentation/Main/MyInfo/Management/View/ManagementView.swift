//
//  ManagementView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import UIKit

import SnapKit

class ManagementView: BaseView {
    let managementTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.separatorStyle = .none
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        self.addSubview(managementTableView)
    }
    
    override func setConstraints() {
        managementTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
}
