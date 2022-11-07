//
//  CertificationViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

import RxCocoa
import RxSwift

class CertificationViewController: BaseViewController {
    let mainView = CertificationView()
    let viewModel = CertificationViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        
    }
    
    override func bindData() {
        mainView.certificationTextField.rx.text
            .orEmpty
            .changed
            .withUnretained(self)
            .bind { (vc, value) in
                vc.mainView.certificationTextField.text = vc.viewModel.format(with: "XXX-XXXX-XXXX", phone: value)
                
                value.count == 13 ? vc.mainView.requestButton.setEnabledButton(true) : vc.mainView.requestButton.setEnabledButton(false)
            }
            .disposed(by: disposeBag)
        
        mainView.requestButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                
            }
            .disposed(by: disposeBag)
    }
}
