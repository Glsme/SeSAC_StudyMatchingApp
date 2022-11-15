//
//  ProfileTableViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/15.
//

import UIKit

import SnapKit

class ProfileTableViewCell: UITableViewCell {
    lazy var userCardView: ProfileCardView = {
        let view = ProfileCardView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.sesacGray2.cgColor
        view.clipsToBounds = true
        return view
    }()
    
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
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
