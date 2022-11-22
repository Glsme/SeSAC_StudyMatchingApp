//
//  RecivedViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/21.
//

import UIKit

import RxCocoa
import RxSwift

class RecivedViewController: BaseViewController {
    let mainView = SesacCardView()
    let viewModel = SearchedViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureUI() {
        if let data = viewModel.searchedData, data.fromQueueDBRequested.isEmpty {
            mainView.setSearchUI(noSearched: true)
        } else {
            mainView.setSearchUI(noSearched: false)
        }
    }
    
    override func bindData() {
        mainView.noSearchView.reloadButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                print("reload")
                if vc.viewModel.lat != 0, vc.viewModel.long != 0 {
                    vc.viewModel.requsetSearchData(lat: vc.viewModel.lat, long: vc.viewModel.long) { response in
                        switch response {
                        case .success(let success):
                            print(success)
                            
                            vc.viewModel.searchedData = success
                            vc.configureUI()
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
        
        mainView.noSearchView.changeButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                print("change")
                vc.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
