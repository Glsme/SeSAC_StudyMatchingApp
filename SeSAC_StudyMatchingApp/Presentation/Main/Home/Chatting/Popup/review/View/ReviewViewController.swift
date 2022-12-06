//
//  ReviewViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/30.
//

import UIKit

import RxCocoa
import RxGesture
import RxSwift

final class ReviewViewController: BaseViewController {
    let mainView = ReviewView()
    let viewModel = ChattingPopupViewModel()
    let disposebag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    override func bindData() {
        view.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.view.endEditing(true)
            }
            .disposed(by: disposebag)
        
        mainView.closeButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.dismiss(animated: false)
            }
            .disposed(by: disposebag)
        
        mainView.reviewButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                if vc.mainView.reviewButton.backgroundColor == .sesacGreen {
                    let reputation = vc.setReputation()
                    let comment = vc.mainView.reviewTextView.text ?? ""
                    
                    vc.viewModel.requestReview(uid: vc.viewModel.uid, reputation: reputation, comment: comment) {
                        vc.dismiss(animated: false) {
                            guard let topVC = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
                            
                            guard let vcs = topVC.navigationController?.viewControllers else { return }
                            
                            for vc in vcs {
                                if let rootVC = vc as? HomeViewController {
                                    topVC.navigationController?.popToViewController(rootVC, animated: false)
                                }
                            }
                        }
                    }
                } else {
                    vc.view.makeToast("리뷰 버튼, 혹은 내용을 입력해주세요.", position: .center)
                }
            }
            .disposed(by: disposebag)
        
        mainView.reviewTextView.rx.didChange
            .withUnretained(self)
            .bind { (vc, text) in
                let checkBool: Bool = vc.mainView.checkOtherButtonTabOrTextviewIsNotNil()
                vc.mainView.reviewButton.setEnabledButton(checkBool)
            }
            .disposed(by: disposebag)
    }
    
    func setReputation() -> Array<Int> {
        var array: Array<Int> = Array<Int>(repeating: 0, count: 6)
        
        if mainView.firstButton.backgroundColor == .sesacGreen {
            array[0] = 1
        }
        
        if mainView.secondButton.backgroundColor == .sesacGreen {
            array[1] = 1
        }
        
        if mainView.thirdButton.backgroundColor == .sesacGreen {
            array[2] = 1
        }
        
        if mainView.fourthButton.backgroundColor == .sesacGreen {
            array[3] = 1
        }
        
        if mainView.fifthButton.backgroundColor == .sesacGreen {
            array[4] = 1
        }
        
        if mainView.sixthButton.backgroundColor == .sesacGreen {
            array[5] = 1
        }
        
        return array
    }
}
