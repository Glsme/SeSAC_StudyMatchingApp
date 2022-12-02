//
//  ShopBaseView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/12/02.
//

import UIKit

import SnapKit

class ShopBaseView: BaseView {
    let baseView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        self.addSubview(baseView)
    }
    
    override func setConstraints() {
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
