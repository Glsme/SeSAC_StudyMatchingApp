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
    
    public func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
    func setNavigationTitle(_ title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14) ?? UIFont.systemFont(ofSize: 14)]
    }
}
