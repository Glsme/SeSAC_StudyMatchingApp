//
//  ManagementViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import UIKit

import SnapKit
import RxDataSources
import RxSwift

class ManagementViewController: BaseViewController {
    let mainView = ManagementView()
    let viewModel = ManagementViewModel()
    let disposeBag = DisposeBag()
    var cardToggle: Bool = false
        
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        mainView.cardView.backgroundImageView.image = UIImage(named: SesacBGAssets.sesacBG7.rawValue)
        mainView.cardView.profileImageView.image = UIImage(named: SesacCharaterAssets.sesacFace5.rawValue)
    }
    
    override func bindData() {
        mainView.withdrawView.titleButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.cardToggle.toggle()
                print("tap")
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
//                    vc.mainView.test1.isHidden = vc.cardToggle
                }
            }
            .disposed(by: disposeBag)
    }
}
