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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
                
                vc.viewModel.updateProfile(sesac: vc.viewModel.currentSesacImage, background: 0) { response in
                    switch response {
                    case .success:
                        vc.view.makeToast("성공적으로 저장되었습니다", position: .center)
                    case .dontHaveItem:
                        vc.view.makeToast("구매가 필요한 아이템이 있어요", position: .center)
                    default:
                        print(response)
                    }
                }
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
        
        vc.backgroundVC.mainView.backgroundCollectionView.rx.itemSelected
            .withUnretained(self)
            .bind { vc, value in
                print("tap")
                let imageString = vc.viewModel.setBGImage(index: value.item)
                vc.mainView.imageBGView.image = UIImage(named: imageString)
            }
            .disposed(by: disposebag)
    }
    
    func requestData() {
        viewModel.requestShopMyInfo { [weak self] data in
            guard let self = self else { return }
            self.viewModel.shopInfoData = data
            self.vc.backgroundVC.viewModel.shopInfoData = data
            self.vc.backgroundVC.mainView.backgroundCollectionView.reloadData()
            
            let imageString = self.viewModel.setCharacterImage(index: data.sesac)
            let bgImageString = self.viewModel.setBGImage(index: data.background)
            self.mainView.characterView.image = UIImage(named: imageString)
            self.mainView.imageBGView.image = UIImage(named: bgImageString)
        }
    }
}
