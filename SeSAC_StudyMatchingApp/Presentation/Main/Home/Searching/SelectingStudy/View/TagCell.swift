//
//  TagCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/16.
//

import UIKit

import SnapKit

final class TagCell: UICollectionViewCell {
    lazy var tagView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.sesacGreen.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.textColor = .sesacGreen
        view.backgroundColor = .clear
        view.numberOfLines = 1
        return view
    }()
    
    lazy var deleteImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "xmark")
        view.tintColor = .sesacGreen
        view.contentMode = .scaleAspectFit
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
        [titleLabel, deleteImageView].forEach {
            tagView.addSubview($0)
        }
        
        self.addSubview(tagView)
    }
    
    func setConstraints() {
        tagView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(deleteImageView.snp.leading).offset(-4)
        }
        
        deleteImageView.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.width.equalTo(16)
            make.height.equalTo(16)
            make.centerY.equalToSuperview()
        }
    }
}
