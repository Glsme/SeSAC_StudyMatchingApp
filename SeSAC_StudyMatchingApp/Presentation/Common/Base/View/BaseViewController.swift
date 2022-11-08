//
//  BaseViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

import Toast

public class BaseViewController: UIViewController, BaseViewProtocol, RxSwiftProtocol {
    public override func viewDidLoad() {
        view.backgroundColor = .white
        configureUI()
        setConstraints()
        bindData()
    }
    
    public func configureUI() { }
    public func setConstraints() { }
    public func bindData() { }
}
