//
//  HomeViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/11.
//

import UIKit

final class HomeViewController: BaseViewController {
    let mainView = HomeView()
    let viewModel = MainViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
