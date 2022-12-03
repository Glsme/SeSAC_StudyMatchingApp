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
import Toast

final class CertificationRequestViewController: BaseViewController {
    let mainView = CertificationRequsetView()
    let viewModel = CertificationRequestViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goToSaveLastViewController()
    }
    
    override func bindData() {
        let input = CertificationRequestViewModel.Input(certificationText: mainView.phoneNumberTextField.textField.rx.text, requstButtonTapped: mainView.requestButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        view.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        mainView.phoneNumberTextField.textField.rx.controlEvent(.editingDidBegin)
            .withUnretained(self)
            .bind { (vc, _) in
                vc.mainView.phoneNumberTextField.line.backgroundColor = .black
            }
            .disposed(by: disposeBag)
        
        mainView.phoneNumberTextField.textField.rx.controlEvent(.editingDidEnd)
            .withUnretained(self)
            .bind { (vc, _) in
                vc.mainView.phoneNumberTextField.line.backgroundColor = .sesacGray3
            }
            .disposed(by: disposeBag)
        
        output.certificationText
            .withUnretained(self)
            .bind { (vc, value) in
                if value.count <= 12 {
                    vc.mainView.phoneNumberTextField.textField.text = vc.viewModel.changePhoneNumformat(with: "XXX-XXX-XXXX", phone: value)
                } else {
                    vc.mainView.phoneNumberTextField.textField.text = vc.viewModel.changePhoneNumformat(with: "XXX-XXXX-XXXX", phone: value)
                }
                
                guard let text = vc.mainView.phoneNumberTextField.textField.text else { return }
                
                if text.count >= 12 {
                    vc.mainView.requestButton.setEnabledButton(true)
                } else {
                    vc.mainView.requestButton.setEnabledButton(false)
                }
            }
            .disposed(by: disposeBag)
        
        output.requsetButtonTapped
            .withUnretained(self)
            .bind { (vc, _) in
                guard let text = vc.mainView.phoneNumberTextField.textField.text else { return }
                guard text.count > 11 else {
                    self.view.makeToast(CertificationError.InvalidFormat.errorDescription, position: .center)
                    return
                }
                
                if vc.viewModel.vaildPhoneNumber(text) {
                    self.view.makeToast(CertificationRequestMents.validFormat.rawValue, position: .center)
                    
                    vc.viewModel.requsetPhoneAuth(text) { valid in
                        if valid == CertificationRequestMents.validFormat.rawValue {
                            let nextVC = CertificationReceivingViewController()
                            vc.transViewController(ViewController: nextVC, type: .push)
                        } else {
                            self.view.makeToast(valid, position: .center)
                        }
                    }
                } else {
                    self.view.makeToast(CertificationError.InvalidFormat.errorDescription, position: .center)
                }
                
            }
            .disposed(by: disposeBag)
    }
}

extension CertificationRequestViewController {
    func goToSaveLastViewController() {
        if UserManager.certificationCode == LoginError.unregisteredUser.rawValue {
            let nicknameVC = NicknameViewController()
            self.transViewController(ViewController: nicknameVC, type: .pushWithoutAni)
        }
    }
}
