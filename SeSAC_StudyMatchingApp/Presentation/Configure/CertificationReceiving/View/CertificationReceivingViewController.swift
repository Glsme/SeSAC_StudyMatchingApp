//
//  CertificationReceivingViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

import FirebaseAuth
import FirebaseCore
import RxCocoa
import RxGesture
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
                vc.setAuthVerificationID(key)
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
    
    private func setAuthVerificationID(_ verificationCode: String) {
        mainView.requestButton.isEnabled = false

        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
        
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("error \(error)")
                self.view.makeToast("Error")
            } else {
                self.view.makeToast("Success")
            }
        }
        
        mainView.requestButton.isEnabled = true
    }
}