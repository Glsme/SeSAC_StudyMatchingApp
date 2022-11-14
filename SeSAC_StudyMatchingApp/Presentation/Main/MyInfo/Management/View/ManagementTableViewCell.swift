//
//  ManagementTableViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import UIKit

class ManagementTableViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        return view
    }()
    
    lazy var manButton: GreenSlectedButton = {
        let view = GreenSlectedButton()
        view.setTitle("남자", for: .normal)
        return view
    }()
    
    lazy var womanButton: GreenSlectedButton = {
        let view = GreenSlectedButton()
        view.setTitle("남자", for: .normal)
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
        [titleLabel, manButton, womanButton].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints(index: Int) {
        switch index {
        case 1:
            setDefaultConstraints()
            
        case 2:
            setDefaultConstraints()
        case 3:
            setDefaultConstraints()
        case 4:
            print("hi")
        case 5:
            setDefaultConstraints()
        default:
            break
        }
    }
    
    func setDefaultConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading)
        }
    }
    
    func setGenderConstraints() {
        setDefaultConstraints()
        
        womanButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(48)
            make.width.equalTo(56)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
}
