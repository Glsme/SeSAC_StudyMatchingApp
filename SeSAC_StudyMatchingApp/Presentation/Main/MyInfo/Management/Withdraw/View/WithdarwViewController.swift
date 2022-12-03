//
//  WithdarwViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/16.
//

import UIKit

import RxCocoa
import RxSwift

final class WithdarwViewController: BaseViewController {
    let mainView = WithdrawPopupView()
    let viewModel = WithdrawViewModel()
    let disposeBag = DisposeBag()
    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    
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
        
        mainView.okButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.requsetWithdarw { response in
                    switch response {
                    case .success(_):
                        vc.viewModel.removeAllUserDefaultsData()
                        
                        guard let delegate = self.sceneDelegate else { return }
                        delegate.window?.rootViewController = OnboardingViewController()
                    case .failure(let error):
                        switch error {
                        case .unregisteredUser:
                            guard let delegate = self.sceneDelegate else { return }
                            delegate.window?.rootViewController = OnboardingViewController()
                        default:
                            break
                        }
                        vc.dismiss(animated: false)
                    }
                }
            }
            .disposed(by: disposeBag)
        
    }
}
