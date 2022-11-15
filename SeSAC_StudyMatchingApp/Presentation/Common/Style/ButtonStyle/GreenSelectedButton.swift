//
//  GreenSelectedButton.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import UIKit

class GreenSelectedButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        titleLabel?.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        setSelectedStyle(false)
    }
    
    func setSelectedStyle(_ selected: Bool) {
        if selected {
            setTitleColor(.white, for: .normal)
            backgroundColor = .sesacGreen
            layer.borderColor = UIColor.sesacGreen.cgColor
        } else {
            setTitleColor(.black, for: .normal)
            backgroundColor = .white
            layer.borderColor = UIColor.sesacGray4.cgColor
        }
    }
}
