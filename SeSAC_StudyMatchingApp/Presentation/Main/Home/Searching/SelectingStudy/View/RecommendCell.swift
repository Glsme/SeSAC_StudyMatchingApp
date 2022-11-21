//
//  RecommandCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/17.
//

import UIKit

import SnapKit

class RecommendCell: UICollectionViewCell {
    lazy var recommandView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.sesacGray4.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.textColor = .black
        view.backgroundColor = .clear
        view.numberOfLines = 1
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        recommandView.addSubview(titleLabel)
        self.addSubview(recommandView)
    }
    
    func setConstraints() {
        recommandView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-16)
            make.leading.equalTo(16)
        }
    }
    
    func setMostStyle() {
        recommandView.layer.borderColor = UIColor.sesacError.cgColor
        titleLabel.textColor = .sesacError
    }
}
