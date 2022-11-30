//
//  ReviewViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/30.
//

import UIKit

class ReviewViewController: BaseViewController {
    let mainView = ReviewView()
    let viewModel = ChattingPopupViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
