//
//  ShopView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/30.
//

import UIKit

import SnapKit

class ShopCharacterView: BaseView {
    let imageBGView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: SesacBGAssets.sesacBG1.rawValue)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    let barView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [imageBGView, barView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        imageBGView.snp.makeConstraints { make in
            make.trailing.leading.top.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.5)
        }
        
        barView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(imageBGView)
            make.top.equalTo(imageBGView.snp.bottom)
            make.height.equalTo(44)
        }
    }
}
