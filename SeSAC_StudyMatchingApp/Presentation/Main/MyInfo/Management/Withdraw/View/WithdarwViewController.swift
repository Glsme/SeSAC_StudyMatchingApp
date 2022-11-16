//
//  WithdarwViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/16.
//

import UIKit

import RxCocoa
import RxSwift

class WithdarwViewController: BaseViewController {
    let mainView = WithdrawPopupView()
    let viewModel = WithdrawViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    override func bindData() {
        mainView.cancelButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.dismiss(animated: false)
            }
            .disposed(by: disposeBag)
        
    }
}
