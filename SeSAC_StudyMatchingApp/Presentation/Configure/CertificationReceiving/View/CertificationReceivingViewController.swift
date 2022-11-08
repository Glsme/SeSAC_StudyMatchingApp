//
//  CertificationReceivingViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

import RxCocoa
import RxSwift

final class CertificationReceivingViewController: BaseViewController {
    let mainView = CertificationReceivingView()
    let viewModel = CertificationReceivingViewModel()
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
            .withUnretained(self)
            .subscribe { (vc, value) in
                vc.trimId(value)
                vc.vaildationCertification(value)
            }
            .disposed(by: disposeBag)
        
        mainView.requestButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                guard let key = vc.mainView.certificationTextField.text else { return }
                vc.showCertificationToast(key)
            }
            .disposed(by: disposeBag)
    }
    
    private func trimId(_ text: String) {
      if text.count > 6 {
        let index = text.index(text.startIndex, offsetBy: 6)
          mainView.certificationTextField.text = String(text[..<index])
      }
    }

    
    private func vaildationCertification(_ text: String) {
        if text.count >= 6 {
            mainView.requestButton.setEnabledButton(true)
        } else {
            mainView.requestButton.setEnabledButton(false)
        }
    }
    
    private func showCertificationToast(_ verificationCode: String) {
        if viewModel.setAuthVerificationID(verificationCode) {
            
        } else {
            self.view.makeToast("no ID")
        }
    }
}
