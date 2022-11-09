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
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.makeToast(CertificationReceivingMents.sendNumber.rawValue, position: .center)
    }
    
    override func bindData() {
        let input = CertificationReceivingViewModel.Input(certificationText: mainView.certificationTextField.rx.text, requstButtonTapped: mainView.requestButton.rx.tap)
        let output = viewModel.transform(input: input)
        
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
        
        output.certificationText
            .withUnretained(self)
            .subscribe { (vc, value) in
                vc.trimId(value)
                vc.vaildationCertification(value)
            }
            .disposed(by: disposeBag)
        
        output.requsetButtonTapped
            .withUnretained(self)
            .bind { (vc, _) in
                guard let key = vc.mainView.certificationTextField.text else { return }
                vc.signInWithVerfiyCode(key)
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
            self.view.makeToast(CertificationReceivingMents.notSixNumber.rawValue, position: .center)
        }
    }
    
    private func signInWithVerfiyCode(_ verficationCode: String) {
        mainView.requestButton.isEnabled = false

        viewModel.signInWithVerfiyCode(verficationCode) { result in
            self.view.makeToast(result, position: .center)
        }
        
        mainView.requestButton.isEnabled = true
    }
}
