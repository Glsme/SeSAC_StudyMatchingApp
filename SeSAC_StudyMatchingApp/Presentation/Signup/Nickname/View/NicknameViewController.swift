//
//  NicknameViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import UIKit

import RxCocoa
import RxGesture
import RxSwift

final class NicknameViewController: BaseViewController {
    let mainView = NicknameView()
    let viewModel = NicknameViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        guard let text = UserManager.nickname else { return }
        mainView.nicknameTextField.textField.text = text
        mainView.requestButton.setEnabledButton(true)
        mainView.nicknameTextField.textField.becomeFirstResponder()
    }
    
    override func bindData() {
        let input = NicknameViewModel.Input(nicknameText: mainView.nicknameTextField.textField.rx.text, nextButtonTapped: mainView.requestButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        view.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        mainView.nicknameTextField.textField.rx.controlEvent(.editingDidBegin)
            .withUnretained(self)
            .bind { (vc, _) in
                vc.mainView.nicknameTextField.line.backgroundColor = .black
            }
            .disposed(by: disposeBag)
        
        mainView.nicknameTextField.textField.rx.controlEvent(.editingDidEnd)
            .withUnretained(self)
            .bind { (vc, _) in
                vc.mainView.nicknameTextField.line.backgroundColor = .sesacGray3
            }
            .disposed(by: disposeBag)
        
        output.nicknameText
            .withUnretained(self)
            .bind { (vc, value) in
                if value.count > 0 {
                    vc.mainView.requestButton.setEnabledButton(true)
                } else {
                    vc.mainView.requestButton.setEnabledButton(false)
                }
            }
            .disposed(by: disposeBag)
        
        input.nextButtonTapped
            .withUnretained(self)
            .bind { (vc, _) in
                guard let text = vc.mainView.nicknameTextField.textField.text else { return }
                if text.isEmpty || text.count > 10 {
                    vc.mainView.makeToast(SignupMents.nicknameError.rawValue, position: .center)
                } else {
                    UserManager.nickname = text
                    let nextVC = BirthViewController()
                    vc.transViewController(ViewController: nextVC, type: .push)
                }
            }
            .disposed(by: disposeBag)
    }
}
