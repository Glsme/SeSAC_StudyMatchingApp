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
        let test = HomeViewController()
        
        setViewControllers([homeVC, test], animated: false)
        
        if let items = tabBar.items {
            items[0].selectedImage = UIImage (systemName: "folder.fill")
            items[0].image = UIImage (systemName: "folder")
            items[0].title = "홈"
            
            items[1].selectedImage = UIImage (systemName: "star.fill")
            items[1].image = UIImage (systemName: "star")
            items[1].title="즐겨찾기"
        }
    }
}
