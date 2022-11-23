//
//  MyChatTableViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/23.
//

import UIKit

import SnapKit

class MyChatTableViewCell: UITableViewCell {
    lazy var talkBubble: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.sesacWhiteGreen.cgColor
        return view
    }()
    
    lazy var talkLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 12)
        view.textColor = .sesacGray6
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
        
        talkBubble.addSubview(talkLabel)
        
        [talkBubble, timeLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints() {
        talkBubble.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(16)
            make.width.equalToSuperview().multipliedBy(0.29)
        }
        
        talkLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(talkBubble.snp.leading).offset(-8)
            make.bottom.equalTo(talkBubble.snp.bottom)
            make.leading.equalToSuperview()
        }
    }
}
