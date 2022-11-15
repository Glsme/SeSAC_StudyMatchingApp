//
//  MyInfoTableViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import UIKit

import SnapKit

final class MyInfoTableViewCell: UITableViewCell {
    lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 16)
        view.textAlignment = .left
        return view
    }()
    
    lazy var detailLabel: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .sesacGray7
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        selectionStyle = .none
        [iconView, titleLabel, detailLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints(index: Int) {
        if index == 0 {
            iconView.layer.cornerRadius = 25
            iconView.layer.borderColor = UIColor.sesacGray4.cgColor
            iconView.layer.borderWidth = 1
            
            iconView.snp.makeConstraints { make in
                make.centerY.equalTo(self.snp.centerY)
                make.width.height.equalTo(50)
                make.leading.equalTo(self.snp.leading).offset(15)
            }
            
            titleLabel.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 16)
            
            titleLabel.snp.makeConstraints { make in
                make.centerY.equalTo(iconView.snp.centerY)
                make.leading.equalTo(iconView.snp.trailing).offset(14)
                make.trailing.equalTo(self.snp.trailing)
            }
            
            detailLabel.snp.makeConstraints { make in
                make.centerY.equalTo(iconView.snp.centerY)
                make.trailing.equalTo(self.snp.trailing).offset(-15)
                make.height.equalTo(titleLabel.snp.height)
            }
        } else {
            titleLabel.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 16)

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
}
