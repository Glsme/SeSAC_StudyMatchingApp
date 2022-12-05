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
    let viewModel = ShopSubViewModel()
    let disposebag = DisposeBag()
    let vc = ShopTabViewController()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestData()
    }
    
    override func configureUI() {
        setNavigationTitle("새싹샵")
        view.backgroundColor = .white
        
        
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
        
        vc.characterVC.mainView.characterCollectionView.rx.itemSelected
            .withUnretained(self)
            .bind { vc, value in
                let imageString = vc.viewModel.setCharacterImage(index: value.item)
                vc.viewModel.currentSesacImage = value.item
                vc.mainView.characterView.image = UIImage(named: imageString)
            }
            .disposed(by: disposebag)
    }
    
    func requestData() {
        viewModel.requestShopMyInfo { [weak self] data in
            guard let self = self else { return }
            self.viewModel.shopInfoData = data
            
            let imageString = self.viewModel.setCharacterImage(index: data.sesac)
            self.mainView.characterView.image = UIImage(named: imageString)
        }
    }
}
