//
//  GreenBgButton.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

import SnapKit

final class GreenBgButton: BaseButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        layer.cornerRadius = 8
        setTitleColor(.sesacGray3, for: .disabled)
        setTitleColor(.white, for: .normal)
        setEnabledButton(false)
    }
    
    func setEnabledButton(_ enabled: Bool) {
        if enabled {
            backgroundColor = .sesacGreen
        } else {
            backgroundColor = .sesacGray6
        }
    }
}
