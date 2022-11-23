//
//  AroundSesacView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/21.
//

import UIKit

import SnapKit

class SesacCardView: BaseView {
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.separatorColor = .white
        return view
    }()
    
    lazy var noSearchView = NoSearchView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        self.addSubview(tableView)
        self.addSubview(noSearchView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        noSearchView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func setSearchUI(noSearched: Bool) {
        if noSearched {
            tableView.isHidden = true
            noSearchView.isHidden = false
        } else {
            tableView.isHidden = false
            noSearchView.isHidden = true
        }
    }
}
