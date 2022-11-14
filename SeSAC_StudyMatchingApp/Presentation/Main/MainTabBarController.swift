//
//  MainTabBarController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/12.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        
        let homeVC = HomeViewController()
        let test1 = HomeViewController()
        let test2 = HomeViewController()
        let test3 = HomeViewController()
        
        setViewControllers([homeVC, test1, test2, test3], animated: false)
        
        if let items = tabBar.items {
            items[0].image = UIImage(named: TabBarAssets.homeIcon.rawValue)
            items[0].title = "홈"
            
            items[1].image = UIImage(named: TabBarAssets.shopIcon.rawValue)
            items[1].title = "새싹샵"
            
            items[2].image = UIImage(named: TabBarAssets.friendIcon.rawValue)
            items[2].title = "새싹친구"
            
            items[3].image = UIImage(named: TabBarAssets.myInfoIcon.rawValue)
            items[3].title = "내정보"
        }
    }
}
