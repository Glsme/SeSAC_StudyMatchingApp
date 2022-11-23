//
//  RequestPopupViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/22.
//

import UIKit

import RxCocoa
import RxSwift

class RequestPopupViewController: BaseViewController {
    let mainView = WithdrawPopupView()
    let disposeBag = DisposeBag()
    var uid: String = ""
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    override func configureUI() {
        mainView.setPopupText("스터디를 요청할게요!", subTitle: "상대방이 요청을 수락하면\n채팅창에서 대화를 나눌 수 있어요")
        mainView.subtitleLabel.textColor = .sesacGray7
    }
    
    override func bindData() {
        mainView.cancelButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.dismiss(animated: false)
            }
            .disposed(by: disposeBag)
        
        mainView.okButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.requestMatching(uid: vc.uid)
            }
            .disposed(by: disposeBag)
    }
    
    func requestMatching(uid: String) {
        let api = SesacAPIRouter.studyRequsetPost(uid: uid)
        SesacSignupAPIService.shared.requestStudyRequest(router: api) { [weak self] statusCode in
            print(statusCode)
            guard let self = self else { return }
            switch MatchingCode(rawValue: statusCode) {
            case .success:
                self.dismiss(animated: false) {
                    guard let vc = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
                    vc.view.makeToast("스터디 요청을 보냈습니다", position: .center)
                }
            case .alreadyRequestMe:
                print("alreadyRequsetMe")
                self.dismiss(animated: false) {
                    guard let vc = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
                    vc.view.makeToast("상대방도 스터디를 요청하여 매칭되었습니다.\n잠시 후 채팅방으로 이동합니다", position: .center) { didTap in
                        //push
                    }
                }
            case .stopRequest:
                self.dismiss(animated: false) {
                    guard let vc = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
                    vc.view.makeToast("상대방이 스터디 찾기를 그만두었습니다.", position: .center)
                }
            default:
                print(MatchingCode(rawValue: statusCode)!)
            }
        }
    }
}

enum MatchingCode: Int {
    case success = 200
    case alreadyRequestMe = 201
    case stopRequest = 202
    case firebaseTokenError = 401
    case noSignup = 406
    case serverError = 500
    case clientError = 501
}
