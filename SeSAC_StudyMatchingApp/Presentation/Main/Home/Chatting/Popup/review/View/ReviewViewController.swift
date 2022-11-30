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

class ReviewViewController: BaseViewController {
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
                    print("hi")
                } else {
                    vc.view.makeToast("리뷰 버튼, 혹은 내용을 입력해주세요.", position: .center)
                }
            }
            .disposed(by: disposebag)
        
        mainView.reviewTextView.rx.didChange
            .withUnretained(self)
            .bind { (vc, text) in
                print(text)
                let checkBool: Bool = vc.mainView.checkOtherButtonTabOrTextviewIsNotNil()
                vc.mainView.reviewButton.setEnabledButton(checkBool)
            }
            .disposed(by: disposebag)
    }
}
