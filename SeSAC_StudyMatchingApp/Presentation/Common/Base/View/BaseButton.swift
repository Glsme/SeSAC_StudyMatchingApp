//
//  BaseButton.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

public class BaseButton: UIButton, BaseViewProtocol {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    @available (*, unavailable)
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func configureUI() { }
    public func setConstraints() { }
}
