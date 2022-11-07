//
//  BaseViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

class BaseViewController: UIViewController, BaseViewProtocol, RxSwiftProtocol {
    override func viewDidLoad() {
        view.backgroundColor = .white
        configureUI()
        setConstraints()
        bindData()
    }
    
    func configureUI() { }
    func setConstraints() { }
    func bindData() { }
}
