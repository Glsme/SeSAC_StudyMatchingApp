//
//  BirthViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import UIKit

import RxCocoa
import RxSwift

final class BirthViewController: BaseViewController {
    let mainView = BirthView()
    let viewModel = BirthViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bindData() {
        let input = BirthViewModel.Input(nextButton: mainView.requestButton.rx.tap, textField: mainView.yearTextField.textField.rx.text)
        let output = viewModel.transform(input: input)
        
        output.nextButtonTapped
            .withUnretained(self)
            .bind { (vc, _) in
                let targetDate = vc.mainView.datePicker.date
                if vc.viewModel.calculateAge(date: targetDate) {
                    UserManager.birth = vc.viewModel.formatDate(date: targetDate)
                    
                    let nextVC = EmailViewController()
                    vc.transViewController(ViewController: nextVC, type: .push)
                } else {
                    vc.view.makeToast(SignupMents.ageError.rawValue, position: .center)
                }
            }
            .disposed(by: disposeBag)
        
        mainView.datePicker.rx.controlEvent(.valueChanged)
            .withUnretained(self)
            .bind { (vc, _) in
                vc.mainView.requestButton.setEnabledButton(true)
            }
            .disposed(by: disposeBag)
    }
}
