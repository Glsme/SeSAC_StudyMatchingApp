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
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
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
                vc.viewModel.requestDodge(uid: vc.viewModel.uid) {
                    vc.dismiss(animated: false) {
                        let chatVC = ChattingViewController()
                        guard let vc = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
                        vc.navigationController?.popViewController(animated: false)
                    }
                }
            }
            .disposed(by: disposebag)
    }
}
