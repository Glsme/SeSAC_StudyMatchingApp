//
//  CancelVIewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/30.
//

import UIKit

import RxCocoa
import RxSwift

class CancelViewController: BaseViewController {
    let mainView = WithdrawPopupView()
    let viewModel = ChattingPopupViewModel()
    let disposebag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureUI() {
        mainView.setPopupText("스터디를 취소하겠습니까?", subTitle: "스터디를 취소하시면 패널티가 부과됩니다.")
    }
    
    override func bindData() {
        mainView.cancelButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.dismiss(animated: false)
            }
            .disposed(by: disposebag)
        
        mainView.okButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                
            }
            .disposed(by: disposebag)
    }
}
