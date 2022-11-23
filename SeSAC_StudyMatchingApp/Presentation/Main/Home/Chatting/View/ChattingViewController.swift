//
//  ChattingViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/23.
//

import UIKit

class ChattingViewController: BaseViewController {
    let viewModel = ChattingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureUI() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false
        
        guard let data = viewModel.data else { return }
        setNavigationTitle(data.matchedNick ?? "새싹")
    }
}
