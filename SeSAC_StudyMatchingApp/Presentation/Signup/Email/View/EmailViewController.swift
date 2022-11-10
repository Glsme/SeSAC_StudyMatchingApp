//
//  EmailViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import UIKit

import RxCocoa
import RxSwift

class EmailViewController: BaseViewController {
    let mainView = EmailView()
    let viewModel = EmailViewModel()
    let disposeBag = DisposeBag()
 
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureUI() {
        mainView.emailTextField.textField.becomeFirstResponder()
    }
    
    override func bindData() {
        let input = EmailViewModel.Input(emailText: mainView.emailTextField.textField.rx.text, nextButtonTapped: mainView.requestButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        mainView.emailTextField.textField.rx.controlEvent(.editingDidBegin)
            .withUnretained(self)
            .bind { (vc, _) in
                vc.mainView.emailTextField.line.backgroundColor = .black
            }
            .disposed(by: disposeBag)
        
        mainView.emailTextField.textField.rx.controlEvent(.editingDidEnd)
            .withUnretained(self)
            .bind { (vc, _) in
                vc.mainView.emailTextField.line.backgroundColor = .sesacGray3
            }
            .disposed(by: disposeBag)
        
        output.emailText
            .withUnretained(self)
            .bind { (vc, value) in
                if vc.viewModel.vaildEmail(value) {
                    vc.mainView.requestButton.setEnabledButton(true)
                } else {
                    vc.mainView.requestButton.setEnabledButton(false)
                }
            }
            .disposed(by: disposeBag)
        
        output.nextButtonTapped
            .withUnretained(self)
            .bind { (vc, value) in
                guard let text = vc.mainView.emailTextField.textField.text else { return }
                if vc.viewModel.vaildEmail(text) {
                    UserManager.email = text
                    
                    let nextVC = GenderViewController()
                    vc.transViewController(ViewController: nextVC, type: .push)
                } else {
                    vc.view.makeToast(SignupMents.InvalidEmailForm.rawValue, position: .center)
                }
            }
            .disposed(by: disposeBag)
    }
}
