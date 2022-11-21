//
//  AroundSesacTableViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/21.
//

import UIKit

import SnapKit

class AroundSesacTableViewCell: UITableViewCell {
    lazy var cardView = ProfileCardView()
    var hiddenFlag = true
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.contentView.addSubview(cardView)
        selectionStyle = .none
    }
    
    func setConstraints() {
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    func setHidden(_ bool: Bool) {
        cardView.titleView.isHidden = bool
    }
}
