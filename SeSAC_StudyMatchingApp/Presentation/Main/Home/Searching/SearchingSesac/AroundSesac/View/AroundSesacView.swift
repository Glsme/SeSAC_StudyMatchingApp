//
//  AroundSesacView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/21.
//

import UIKit

import SnapKit

class AroundSesacView: BaseView {
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.separatorColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        self.addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
