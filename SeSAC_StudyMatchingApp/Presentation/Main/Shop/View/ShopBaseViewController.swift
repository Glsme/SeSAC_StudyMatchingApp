//
//  ShopBaseViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/12/02.
//

import UIKit

import SnapKit
import RxCocoa
import RxSwift

final class ShopBaseViewController: BaseViewController {
    let mainView = ShopCharacterView()
    let disposebag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        setNavigationTitle("새싹샵")
        view.backgroundColor = .white
        
        let vc = ShopTabViewController()
        self.addChild(vc)
        self.view.addSubview(vc.view)
        
        vc.view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(mainView.safeAreaLayoutGuide)
            make.top.equalTo(mainView.imageBGView.snp.bottom)
        }
    }
    
    override func bindData() {
        mainView.saveButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                print("Save Button Tap")
            }
            .disposed(by: disposebag)
    }
}
