//
//  GenderViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import UIKit

import RxCocoa
import RxSwift

class GenderViewController: BaseViewController {
    let mainView = GenderView()
    let viewModel = GenderViewModel()
    let disposeBag = DisposeBag()
    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bindData() {
        let input = GenderViewModel.Input(womanButtonTapped: mainView.womanButton.rx.tap, manButtonTapped: mainView.manButton.rx.tap, nextButtonTapped: mainView.requestButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.manButtonTapped
            .withUnretained(self)
            .bind { (vc, _) in
                if vc.mainView.manButton.backgroundColor == .sesacWhiteGreen {
                    vc.mainView.manButton.backgroundColor = .white
                    vc.mainView.manButton.layer.borderColor = UIColor.sesacGray4.cgColor
                } else if vc.mainView.womanButton.backgroundColor == .white {
                    vc.mainView.manButton.backgroundColor = .sesacWhiteGreen
                    vc.mainView.manButton.layer.borderColor = UIColor.sesacWhiteGreen.cgColor
                } else if vc.mainView.womanButton.backgroundColor == .sesacWhiteGreen {
                    vc.mainView.manButton.backgroundColor = .sesacWhiteGreen
                    vc.mainView.manButton.layer.borderColor = UIColor.sesacWhiteGreen.cgColor
                    vc.mainView.womanButton.backgroundColor = .white
                    vc.mainView.womanButton.layer.borderColor = UIColor.sesacGray4.cgColor
                }
            }
            .disposed(by: disposeBag)
        
        output.womanButtonTapped
            .withUnretained(self)
            .bind { (vc, _) in
                if vc.mainView.womanButton.backgroundColor == .sesacWhiteGreen {
                    vc.mainView.womanButton.backgroundColor = .white
                    vc.mainView.womanButton.layer.borderColor = UIColor.sesacGray4.cgColor
                } else if vc.mainView.manButton.backgroundColor == .white {
                    vc.mainView.womanButton.backgroundColor = .sesacWhiteGreen
                    vc.mainView.womanButton.layer.borderColor = UIColor.sesacWhiteGreen.cgColor
                } else if vc.mainView.manButton.backgroundColor == .sesacWhiteGreen {
                    vc.mainView.womanButton.backgroundColor = .sesacWhiteGreen
                    vc.mainView.womanButton.layer.borderColor = UIColor.sesacWhiteGreen.cgColor
                    vc.mainView.manButton.backgroundColor = .white
                    vc.mainView.manButton.layer.borderColor = UIColor.sesacGray4.cgColor
                }
            }
            .disposed(by: disposeBag)
        
        output.nextButtonTapped
            .withUnretained(self)
            .bind { (vc, _) in
                guard vc.mainView.manButton.backgroundColor == .sesacWhiteGreen || vc.mainView.womanButton.backgroundColor == .sesacWhiteGreen else {
                    vc.view.makeToast("성별을 선택해 주세요", position: .center)
                    return
                }
                
                if vc.mainView.manButton.backgroundColor == .sesacWhiteGreen {
                    UserManager.gender = 1
                } else if vc.mainView.womanButton.backgroundColor == .sesacWhiteGreen {
                    UserManager.gender = 0
                }
                
                vc.viewModel.requsetSignup { result in
                    switch result {
                    case .success(let success):
                        let result = success.toDomain()
                        UserManager.sesac = result.sesac
                        UserManager.nickname = result.nick
                        guard let delegate = vc.sceneDelegate else { return }
                        delegate.window?.rootViewController = MainTabBarController()
//                        let homeVC = HomeViewController()
//                        vc.transViewController(ViewController: homeVC, type: .presentFullscreen)
                    case .failure(let error):
                        vc.responseError(LoginError.alreadySignup)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    func responseError(_ errorCode: LoginError) {
        switch errorCode {
        case .cantUseNickname:
            guard let vcs = navigationController?.viewControllers else { return }
            
            for vc in vcs {
                if let rootVC = vc as? NicknameViewController {
                    navigationController?.popToViewController(rootVC, animated: false)
                    rootVC.view.makeToast(SignupMents.cantuseNickname.rawValue)
                }
            }
        case .firbaseTokenError:
            viewModel.refreshAndRetryLogin { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success(let success):
                    let result = success.toDomain()
                    UserManager.sesac = result.sesac
                    UserManager.nickname = result.nick
                    guard let delegate = self.sceneDelegate else { return }
                    delegate.window?.rootViewController = MainTabBarController()
//                    let vc = HomeViewController()
//                    self.transViewController(ViewController: vc, type: .presentFullscreen)
                case .failure(let error):
                    print(#function, error)
                }
            }
        case .alreadySignup:
            guard let vcs = navigationController?.viewControllers else { return }
            
            for vc in vcs {
                if let rootVC = vc as? CertificationRequestViewController {
                    navigationController?.popToViewController(rootVC, animated: false)
                    rootVC.view.makeToast(CertificationRequestMents.alreadySignup.rawValue)
                }
            }
        case .unregisteredUser:
            print("unregisteredUser")
        case .serverError:
            print("serverError")
        case .clientError:
            print("clientError")
        }
    }
}
