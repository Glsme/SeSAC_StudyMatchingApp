//
//  CancelVIewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/30.
//

import UIKit

import RxCocoa
import RxSwift

final class CancelViewController: BaseViewController {
    let mainView = WithdrawPopupView()
    let viewModel = ChattingPopupViewModel()
    let disposebag = DisposeBag()
    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureUI() {
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
                        guard let topVC = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
                        
                        guard let vcs = topVC.navigationController?.viewControllers else { return }
                        
                        for vc in vcs {
                            if let rootVC = vc as? HomeViewController {
                                topVC.navigationController?.popToViewController(rootVC, animated: false)
                            }
                        }
                    }
                }
            }
            .disposed(by: disposebag)
    }
}
