//
//  SplashController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/11.
//

import UIKit

final class SplashController: BaseViewController {
    let mainView = SplashView()
    let viewMdoel = SplashViewModel()
    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureUI() {
        animateLaunchScreen()
    }
    
    func animateLaunchScreen() {
        mainView.labelImageView.alpha = 0
        mainView.imageView.alpha = 0
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            guard let self = self else { return }
            
            self.mainView.labelImageView.alpha = 1
            self.mainView.imageView.alpha = 1
        }) { [weak self] _ in
            guard let self = self else { return }
            
            self.checkAppFirstRunning()
        }
    }
    
    func checkAppFirstRunning() {
        if UserManager.first {
            // 앱 실행이 처음일 떄
            let vc = OnboardingViewController()
            dismiss(animated: false)
            transViewController(ViewController: vc, type: .presentFullScreenWithoutAni)
        } else {
            // 앱 처음 실행이 아닐때, 온보딩에서 시작하기 눌렀을 때
            print("not first")
            // 로그인 할 token 있는지 확인
            checkIDToken()
        }
    }
    
    func checkIDToken() {
        if UserManager.authVerificationToken != nil {
            // 로그인 시도
            viewMdoel.loginSesacServer { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success(let success):
                    // 로그인 성공!
                    let result = success.toDomain()
                    UserManager.sesac = result.sesac
                    UserManager.nickname = result.nick
                    guard let delegate = self.sceneDelegate else { return }
                    delegate.window?.rootViewController = MainTabBarController()
                case .failure(let error):
                    self.responseError(error.rawValue)
                }
            }
        } else {
            // 핸드폰 인증 서비스로 이동
            let vc = CertificationRequestViewController()
            let naviVC = UINavigationController(rootViewController: vc)
            transViewController(ViewController: naviVC, type: .presentFullScreenWithoutAni)
        }
    }
    
    func responseError(_ errorCode: Int) {
        switch errorCode {
        case 401:
            print("파이어베이스 토큰 에러")
            viewMdoel.refreshAndRetryLogin { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success(let success):
                    let result = success.toDomain()
                    UserManager.sesac = result.sesac
                    UserManager.nickname = result.nick
                    guard let delegate = self.sceneDelegate else { return }
                    delegate.window?.rootViewController = MainTabBarController()
                case .failure(let failure):
                    print(failure)
                }
            }
        case 406:
            print("미가입 유저!!!!!")
            let vc = CertificationRequestViewController()
            let naviVC = UINavigationController(rootViewController: vc)
            transViewController(ViewController: naviVC, type: .presentFullScreenWithoutAni)
        case 500:
            print("서버 에러")
        case 501:
            print("클라이언트 에러다~")
        default:
            print("대체 무엇을 잘못한거냐")
        }
    }
}
