//
//  ProfileTableViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/15.
//

import UIKit

import SnapKit

class ProfileTableViewCell: UITableViewCell {
    lazy var userCardView = ProfileCardView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        selectionStyle = .none
        contentView.addSubview(userCardView)
    }
    
    func setConstraints() {
        userCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
