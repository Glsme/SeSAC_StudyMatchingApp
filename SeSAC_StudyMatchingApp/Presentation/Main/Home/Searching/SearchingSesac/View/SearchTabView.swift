//
//  SearchTabView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/21.
//

import UIKit

import SnapKit

class SearchTabView: BaseView {
    lazy var changeButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setSelectedStyle(true)
        view.setTitle("스터디 변경하기", for: .normal)
        return view
    }()
    
    lazy var reloadButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.sesacGreen.cgColor
        view.layer.borderWidth = 1
        view.setImage(UIImage(named: SearchAssets.reload.rawValue), for: .normal)
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
    }
    
    override func configureUI() {
        [changeButton, reloadButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        changeButton.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(16)
            make.bottom.equalTo(reloadButton.snp.bottom)
            make.height.equalTo(reloadButton.snp.height)
            make.trailing.equalTo(reloadButton.snp.leading).offset(-8)
        }
        
        reloadButton.snp.makeConstraints { make in
            make.height.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.128)
            make.bottom.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
}
