//
//  MyInfoView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import UIKit

import SnapKit

final class MyInfoView: BaseView {
    let myInfoTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.separatorStyle = .singleLine
        view.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        self.addSubview(myInfoTableView)
    }
    
    override func setConstraints() {
        myInfoTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
