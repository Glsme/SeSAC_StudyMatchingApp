//
//  TagCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/16.
//

import UIKit

import SnapKit

class TagCell: UICollectionViewCell {
    let tagButton: UIButton = {
        let view = UIButton()
        view.layer.borderColor = UIColor.sesacGray4.cgColor
        view.layer.borderWidth = 1
        view.titleLabel?.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.setTitleColor(.black, for: .normal)
        
        var config = UIButton.Configuration.tinted()
        var titleAttr = AttributedString.init("gd")
//        titleAttr.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
//        titleAttr.foregroundColor = .black
        config.attributedTitle = titleAttr
        config.titlePadding = 16
        config.baseBackgroundColor = .white
        view.configuration = config
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureUI() {
        self.addSubview(tagButton)
    }
    
    func setConstraints() {
        tagButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
