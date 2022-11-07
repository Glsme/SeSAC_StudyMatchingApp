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
    let viewModel = CertificationViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindData() {
        mainView.certificationTextField.rx.controlEvent(.editingDidBegin)
            .withUnretained(self)
            .bind { (vc, _) in
                vc.mainView.line.backgroundColor = .black
            }
        
        mainView.certificationTextField.rx.controlEvent(.editingDidEndOnExit)
            .withUnretained(self)
            .bind { (vc, _) in
                vc.mainView.line.backgroundColor = .sesacGray3
            }
        
        mainView.certificationTextField.rx.text
            .orEmpty
            .changed
            .withUnretained(self)
            .bind { (vc, value) in
                vc.mainView.certificationTextField.text = vc.viewModel.format(with: "XXX-XXXX-XXXX", phone: value)
            }
            .disposed(by: disposeBag)
        
        mainView.requestButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                let pushVC = CertificationReceivingViewController()
                vc.navigationController?.pushViewController(pushVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
