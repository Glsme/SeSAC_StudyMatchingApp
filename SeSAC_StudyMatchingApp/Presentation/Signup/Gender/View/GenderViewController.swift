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
        let input = GenderViewModel.Input()
        let output = viewModel.transform(input: input)
        
        mainView.manButton.rx.tap
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
        
        mainView.womanButton.rx.tap
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
    }
}
