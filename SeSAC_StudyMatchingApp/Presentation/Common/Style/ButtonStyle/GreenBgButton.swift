//
//  GreenBgButton.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

final class GreenBgButton: BaseButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        layer.cornerRadius = 8
        setTitleColor(.sesacGray3, for: .disabled)
        setTitleColor(.white, for: .normal)
    }
    
    func setEnabledButton(_ enabled: Bool) {
        if enabled {
            self.isEnabled = true
            backgroundColor = .sesacGreen
            
        } else {
            self.isEnabled = false
            backgroundColor = .sesacGray6
        }
    }
}
