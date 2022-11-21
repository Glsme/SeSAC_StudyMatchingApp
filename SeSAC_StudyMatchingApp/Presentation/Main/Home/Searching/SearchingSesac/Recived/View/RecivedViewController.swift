//
//  RecivedViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/21.
//

import UIKit

class RecivedViewController: BaseViewController {
    let mainView = SesacCardView()
    let viewModel = RecievedViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureUI() {
        if viewModel.searchedData == nil {
            mainView.setSearchUI(noSearched: true)
        } else {
            mainView.setSearchUI(noSearched: false)
        }
    }
}
