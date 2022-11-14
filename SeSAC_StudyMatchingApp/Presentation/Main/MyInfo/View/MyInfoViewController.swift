//
//  MyInfoViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import UIKit

class MyInfoViewController: BaseViewController {
    let mainView = MyInfoView()
    let viewModel = MyInfoViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
