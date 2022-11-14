//
//  MyInfoTableViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import UIKit

import SnapKit

class MyInfoTableViewCell: UITableViewCell {
    let iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 16)
        view.textAlignment = .left
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
        [iconView, titleLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints() {
        iconView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(24)
            make.leading.equalTo(self.snp.leading).offset(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconView.snp.centerY)
            make.leading.equalTo(iconView.snp.trailing).offset(14)
            make.trailing.equalTo(self.snp.trailing)
        }
    }
}
