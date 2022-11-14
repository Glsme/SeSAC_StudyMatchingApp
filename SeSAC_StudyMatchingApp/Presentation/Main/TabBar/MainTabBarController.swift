//
//  MainTabBarController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/12.
//

import UIKit

enum TabBarName: String {
    case home = "홈"
    case sesacShop = "새싹샵"
    case sesacFriend = "새싹친구"
    case myInfo = "내정보"
}

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .sesacGreen

        let homeVC = HomeViewController()
        let test1 = HomeViewController()
        let test2 = HomeViewController()
        let test3 = HomeViewController()
        
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 12) ?? UIFont.systemFont(ofSize: 12)], for: .normal)

        setViewControllers([homeVC, test1, test2, test3], animated: false)
        
        if let items = tabBar.items {
            items[0].image = UIImage(named: TabBarAssets.homeIcon.rawValue)
            items[0].title = TabBarName.home.rawValue
            
            items[1].image = UIImage(named: TabBarAssets.shopIcon.rawValue)
            items[1].title = TabBarName.sesacShop.rawValue
            
            items[2].image = UIImage(named: TabBarAssets.friendIcon.rawValue)
            items[2].title = TabBarName.sesacFriend.rawValue
            
            items[3].image = UIImage(named: TabBarAssets.myInfoIcon.rawValue)
            items[3].title = TabBarName.myInfo.rawValue
        }
    }
}
