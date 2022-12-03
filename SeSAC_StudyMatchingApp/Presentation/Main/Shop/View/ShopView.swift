//
//  ShopView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/30.
//

import UIKit

import SnapKit

final class ShopCharacterView: BaseView {
    lazy var imageBGView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: SesacBGAssets.sesacBG1.rawValue)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    lazy var characterView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: SesacCharaterAssets.sesacFace1.rawValue)
        return view
    }()
    
    lazy var saveButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setSelectedStyle(true)
        view.setTitle("저장하기", for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [imageBGView, characterView, saveButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        imageBGView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.trailing.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.5)
        }
        
        characterView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(imageBGView.snp.bottom).offset(12)
            make.height.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.49)
        }
        
        saveButton.snp.makeConstraints { make in
            make.trailing.top.equalTo(imageBGView).inset(16)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
    }
}
