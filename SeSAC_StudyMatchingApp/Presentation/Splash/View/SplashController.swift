//
//  SplashController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/11.
//

import UIKit

final class SplashController: BaseViewController {
    let mainView = SplashView()
    
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
        
        UIView.animate(withDuration: 1.0, delay: 1.5, options: .curveEaseOut, animations: { [weak self] in
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
            let vc = OnboardingViewController()
            dismiss(animated: false)
            transViewController(ViewController: vc, type: .presentFullScreenWithoutAni)
        } else {
            // 앱 처음 실행이 아닐때, 온보딩에서 시작하기 눌렀을 때
            print("not first")
        }
    }
}
