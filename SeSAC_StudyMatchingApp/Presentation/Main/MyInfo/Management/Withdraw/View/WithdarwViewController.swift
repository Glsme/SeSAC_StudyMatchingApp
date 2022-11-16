//
//  WithdarwViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/16.
//

import UIKit

import RxSwift

class WithdarwViewController: BaseViewController {
    let mainView = WithdrawPopupView()
    let viewModel = WithdrawViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
