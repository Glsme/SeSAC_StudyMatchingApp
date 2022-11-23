//
//  UIViewController+Extension.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/08.
//

import UIKit

extension UIViewController {
    enum Transition {
        case push
        case pushWithoutAni
        case presentNavigation
        case presentFullScreenNavigation
        case present
        case presentFullscreen
        case presentFullScreenWithoutAni
    }
    
    func transViewController<T: UIViewController>(ViewController vc: T, type: Transition) {
        switch type {
        case .pushWithoutAni:
            self.navigationController?.pushViewController(vc, animated: false)
        case .push:
            self.navigationController?.pushViewController(vc, animated: true)
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: vc)
            self.present(navi, animated: true)
        case .presentFullScreenNavigation:
            let navi = UINavigationController(rootViewController: vc)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
        case .presentFullscreen:
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        case .presentFullScreenWithoutAni:
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
}

extension UIViewController {
    // 최상위 뷰컨트롤러를 판단해주는 메서드
    
    var topViewController: UIViewController? {
        return self.topViewController(currentViewController: self)
    }
    
    func topViewController(currentViewController: UIViewController) -> UIViewController {
        if let tabBarController = currentViewController as? UITabBarController, let selectedViewController = tabBarController.selectedViewController {
            return self.topViewController(currentViewController: selectedViewController)
        } else if let navigationController = currentViewController as? UINavigationController, let visibleViewController = navigationController.visibleViewController {
            return self.topViewController(currentViewController: visibleViewController)
        } else if let presentedViewController = currentViewController.presentedViewController {
            return self.topViewController(currentViewController: presentedViewController)
        } else {
            return currentViewController
            
        }
    }
}
