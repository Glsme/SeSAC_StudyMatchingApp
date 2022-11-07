//
//  BaseViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

class BaseViewController: UIViewController, BaseViewProtocol {
    override func viewDidLoad() {
        configureUI()
        setConstraints()
    }
    
    func configureUI() { }
    func setConstraints() { }
}
