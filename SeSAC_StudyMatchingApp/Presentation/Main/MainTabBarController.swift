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
        let test4 = HomeViewController()
        
        setViewControllers([homeVC, test1, test2, test3, test4], animated: false)
        
        if let items = tabBar.items {
            items[0].selectedImage = UIImage (systemName: "folder.fill")
            items[0].image = UIImage (systemName: "folder")
            items[0].title = "홈"
            
            items[1].selectedImage = UIImage (systemName: "star.fill")
            items[1].image = UIImage (systemName: "star")
            items[1].title="즐겨찾기"
            
            items[2].selectedImage = UIImage (systemName: "star.fill")
            items[2].image = UIImage (systemName: "star")
            items[2].title="즐겨찾기"
            
            items[3].selectedImage = UIImage (systemName: "star.fill")
            items[3].image = UIImage (systemName: "star")
            items[3].title="즐겨찾기"
        }
    }
}
