//
//  GenderViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import UIKit

import RxCocoa
import RxSwift

class GenderViewController: BaseViewController {
    let mainView = GenderView()
    let viewModel = GenderViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bindData() {
        let input = GenderViewModel.Input(womanButtonTapped: mainView.womanButton.rx.tap, manButtonTapped: mainView.manButton.rx.tap, nextButtonTapped: mainView.requestButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.manButtonTapped
            .withUnretained(self)
            .bind { (vc, _) in
                if vc.mainView.manButton.backgroundColor == .sesacWhiteGreen {
                    vc.mainView.manButton.backgroundColor = .white
                    vc.mainView.manButton.layer.borderColor = UIColor.sesacGray4.cgColor
                } else if vc.mainView.womanButton.backgroundColor == .white {
                    vc.mainView.manButton.backgroundColor = .sesacWhiteGreen
                    vc.mainView.manButton.layer.borderColor = UIColor.sesacWhiteGreen.cgColor
                } else if vc.mainView.womanButton.backgroundColor == .sesacWhiteGreen {
                    vc.mainView.manButton.backgroundColor = .sesacWhiteGreen
                    vc.mainView.manButton.layer.borderColor = UIColor.sesacWhiteGreen.cgColor
                    vc.mainView.womanButton.backgroundColor = .white
                    vc.mainView.womanButton.layer.borderColor = UIColor.sesacGray4.cgColor
                }
            }
            .disposed(by: disposeBag)
        
        output.womanButtonTapped
            .withUnretained(self)
            .bind { (vc, _) in
                if vc.mainView.womanButton.backgroundColor == .sesacWhiteGreen {
                    vc.mainView.womanButton.backgroundColor = .white
                    vc.mainView.womanButton.layer.borderColor = UIColor.sesacGray4.cgColor
                } else if vc.mainView.manButton.backgroundColor == .white {
                    vc.mainView.womanButton.backgroundColor = .sesacWhiteGreen
                    vc.mainView.womanButton.layer.borderColor = UIColor.sesacWhiteGreen.cgColor
                } else if vc.mainView.manButton.backgroundColor == .sesacWhiteGreen {
                    vc.mainView.womanButton.backgroundColor = .sesacWhiteGreen
                    vc.mainView.womanButton.layer.borderColor = UIColor.sesacWhiteGreen.cgColor
                    vc.mainView.manButton.backgroundColor = .white
                    vc.mainView.manButton.layer.borderColor = UIColor.sesacGray4.cgColor
                }
            }
            .disposed(by: disposeBag)
        
        output.nextButtonTapped
            .withUnretained(self)
            .bind { (vc, _) in
                guard vc.mainView.manButton.backgroundColor == .sesacWhiteGreen || vc.mainView.womanButton.backgroundColor == .sesacWhiteGreen else {
                    vc.view.makeToast("성별을 선택해 주세요", position: .center)
                    return
                }
                
                if vc.mainView.manButton.backgroundColor == .sesacWhiteGreen {
                    UserManager.gender = 1
                } else if vc.mainView.womanButton.backgroundColor == .sesacWhiteGreen {
                    UserManager.gender = 0
                }
                
                vc.viewModel.requsetSignup()
            }
            .disposed(by: disposeBag)
    }
}
