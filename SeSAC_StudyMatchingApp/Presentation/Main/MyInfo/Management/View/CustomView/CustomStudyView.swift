//
//  CustomStudyView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/15.
//

import UIKit

class CustomStudyView: BaseView {
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        return view
    }()
    
    lazy var studyTextField: BlackHighlightTextField = {
        let view = BlackHighlightTextField()
        view.textField.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.setPlaceHolder("스터디를 입력해 주세요")
        view.textField.textAlignment = .left
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [titleLabel, studyTextField].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        studyTextField.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalTo(self.snp.trailing)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.45)
            make.height.equalTo(40)
        }
    }
}
