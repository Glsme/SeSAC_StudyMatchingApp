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
    
    var timerDisposable: Disposable?
    
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
        let input = CertificationReceivingViewModel.Input(certificationText: mainView.certificationTextField.textField.rx.text, requstButtonTapped: mainView.requestButton.rx.tap, retryButtonTapped: mainView.retryButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        resetAndGoTimer()
        
        view.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        mainView.certificationTextField.textField.rx.controlEvent(.editingDidBegin)
            .withUnretained(self)
            .bind { (vc, _) in
                vc.mainView.certificationTextField.line.backgroundColor = .black
            }
            .disposed(by: disposeBag)
        
        mainView.certificationTextField.textField.rx.controlEvent(.editingDidEnd)
            .withUnretained(self)
            .bind { (vc, _) in
                vc.mainView.certificationTextField.line.backgroundColor = .sesacGray3
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
                guard let key = vc.mainView.certificationTextField.textField.text else { return }
                vc.signInWithVerfiyCode(key)
            }
            .disposed(by: disposeBag)
        
        output.retryButtonTapped
            .withUnretained(self)
            .bind { (vc, _) in
                vc.mainView.retryButton.setEnabledButton(false)
                vc.mainView.retryButton.isEnabled = false
                vc.mainView.requestButton.isEnabled = false
                vc.viewModel.requsetPhoneAuth { valid in
                    if !valid.isEmpty {
                        vc.view.makeToast(valid, position: .center)
                    }
                }
                vc.resetAndGoTimer()
                vc.mainView.retryButton.setEnabledButton(true)
                vc.mainView.retryButton.isEnabled = true
                vc.mainView.requestButton.isEnabled = true
            }
            .disposed(by: disposeBag)
    }
    
    private func resetAndGoTimer() {
        timerDisposable?.dispose()
        timerDisposable = Observable<Int>
            .timer(.seconds(1), period: .seconds(1), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { (vc, value) in
                if value > 50, value <= 60 {
                    vc.mainView.timerLabel.text = "00:0\(60-value)"
                } else if value <= 50 {
                    vc.mainView.timerLabel.text = "00:\(60-value)"
                } else {
                    UserDefaults.standard.removeObject(forKey: "authVerificationID")
                    vc.timerDisposable?.dispose()
                }
            })
    }
    
    private func trimId(_ text: String) {
      if text.count > 6 {
        let index = text.index(text.startIndex, offsetBy: 6)
          mainView.certificationTextField.textField.text = String(text[..<index])
      }
    }

    
    private func vaildationCertification(_ text: String) {
        if text.count >= 6 {
            mainView.requestButton.setEnabledButton(true)
        } else {
            mainView.requestButton.setEnabledButton(false)
        }
    }
    
    private func signInWithVerfiyCode(_ verficationCode: String) {
        mainView.requestButton.isEnabled = false

        guard UserManager.authVerificationID != nil else {
            self.view.makeToast(CertificationReceivingMents.timeOver.rawValue, position: .center)
            mainView.requestButton.isEnabled = true
            return
        }
        
        viewModel.signInWithVerfiyCode(verficationCode) { [weak self] result in
            guard let self = self else { return }
            if UserManager.authVerificationID == nil {
                self.view.makeToast(result, position: .center)
            } else {
                self.viewModel.requsetLogin { result in
                    switch result {
                    case .success(let success):
                        
                        let nextVC = HomeViewController()
                        self.transViewController(ViewController: nextVC, type: .presentFullscreen)
                    case .failure(let error):
                        guard let error = error as? LoginError else { return }
                        if error.rawValue == LoginError.unregisteredUser.rawValue {
                            print("미가입 유저!!!!")
                            UserManager.certificationCode = error.rawValue
                            let nextVC = NicknameViewController()
                            self.transViewController(ViewController: nextVC, type: .push)
                        }
                    }
                }
            }
        }
        
        mainView.requestButton.isEnabled = true
    }
}
