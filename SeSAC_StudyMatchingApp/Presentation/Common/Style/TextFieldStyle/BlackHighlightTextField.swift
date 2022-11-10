//
//  BlackHighlightTextField.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import UIKit

import SnapKit

class BlackHighlightTextField: BaseView {
    let line = TextFieldHighlightLine()
    
    let textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [textField, line].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        line.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self)
            make.height.equalTo(1)
        }
        
        textField.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self)
            make.bottom.equalTo(line.snp.top)
        }
    }
    
    func setStyle(font: UIFont?, keyboardType: UIKeyboardType) {
        textField.font = font ?? UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        textField.keyboardType = keyboardType
    }
    
    func setPlaceHolder(_ placeHolder: String) {
        textField.placeholder = placeHolder
    }
}
