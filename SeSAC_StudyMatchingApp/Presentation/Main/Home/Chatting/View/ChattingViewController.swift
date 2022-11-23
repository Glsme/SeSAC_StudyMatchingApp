//
//  ChattingViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/23.
//

import UIKit

import RxCocoa
import RxSwift

class ChattingViewController: BaseViewController {
    let viewModel = ChattingViewModel()
    let disposeBag = DisposeBag()
    let backButton = UIBarButtonItem(image: UIImage(named: CommonAssets.backButton.rawValue), style: .done, target: ChattingViewController.self, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureUI() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        guard let data = viewModel.data else { return }
        setNavigationTitle(data.matchedNick ?? "새싹")
        
    }
    
    override func bindData() {
        backButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                guard let vcs = vc.navigationController?.viewControllers else { return }
                
                for vc in vcs {
                    if let rootVC = vc as? HomeViewController {
                        vc.navigationController?.popToViewController(rootVC, animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
