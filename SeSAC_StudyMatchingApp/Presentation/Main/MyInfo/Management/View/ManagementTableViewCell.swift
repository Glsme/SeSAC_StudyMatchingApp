//
//  ManagementTableViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/15.
//

import UIKit

import SnapKit

class ManagementTableViewCell: UITableViewCell {
    lazy var genderView = CustomGenderView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [genderView].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        
    }
}
