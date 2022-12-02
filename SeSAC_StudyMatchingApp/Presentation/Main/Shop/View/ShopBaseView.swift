//
//  ShopBaseView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/12/02.
//

import UIKit

import SnapKit

class ShopBaseView: BaseView {
    let barView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        self.addSubview(barView)
    }
    
    override func setConstraints() {
        barView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.top.equalToSuperview()
            make.height.equalTo(44)
        }
    }
}
