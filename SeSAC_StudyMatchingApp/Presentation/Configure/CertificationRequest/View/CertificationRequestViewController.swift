//
//  CertificationViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

import RxCocoa
import RxGesture
import RxSwift

class CertificationRequestViewController: BaseViewController {
    let mainView = CertificationRequsetView()
    let viewModel = CertificationRequestViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindData() {
        view.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        mainView.certificationTextField.rx.controlEvent(.editingDidBegin)
            .withUnretained(self)
            .bind { (vc, _) in
                vc.mainView.line.backgroundColor = .black
            }
            .disposed(by: disposeBag)
        
        mainView.certificationTextField.rx.controlEvent(.editingDidEnd)
            .withUnretained(self)
            .bind { (vc, _) in
                vc.mainView.line.backgroundColor = .sesacGray3
            }
            .disposed(by: disposeBag)
        
        mainView.certificationTextField.rx.text
            .orEmpty
            .changed
            .withUnretained(self)
            .bind { (vc, value) in
                vc.mainView.certificationTextField.text = vc.viewModel.format(with: "XXX-XXXX-XXXX", phone: value)
                guard let text = vc.mainView.certificationTextField.text else { return }
                vc.mainView.requestButton.setEnabledButton(vc.viewModel.checkPhoneNumber(text))
            }
            .disposed(by: disposeBag)
        
        mainView.requestButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                guard let text = vc.mainView.certificationTextField.text else { return }
                vc.viewModel.requsetPhoneAuth("011-2580-2580")
//                vc.viewModel.requsetPhoneAuth(text)
                let pushVC = CertificationReceivingViewController()
                vc.transViewController(ViewController: pushVC, type: .push)
            }
            .disposed(by: disposeBag)
    }
}
