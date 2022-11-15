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
        navigationItem.title = "정보 관리"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14) ?? UIFont.systemFont(ofSize: 14)]
        
        guard let ageGroup = try? viewModel.userInfo.value() else { return }
        mainView.ageView.ageSlider.value = [CGFloat(ageGroup.ageMin), CGFloat(ageGroup.ageMax)]
    }
    
    override func bindData() {
        mainView.cardView.nicknameView.moreButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.cardToggle.toggle()
                print("tap")
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
                    vc.mainView.cardView.titleView.isHidden = vc.cardToggle
                }
            }
            .disposed(by: disposeBag)
        
        mainView.ageView.ageSlider.rx.controlEvent(.valueChanged)
            .withUnretained(self)
            .bind { (vc, _) in
                let value = vc.mainView.ageView.ageSlider.value
                vc.mainView.ageView.ageLabel.text = "\(Int(value[0])) - \(Int(value[1]))"
            }
            .disposed(by: disposeBag)
    }
}
