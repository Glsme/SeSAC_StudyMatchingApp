//
//  RecievedPopupViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/23.
//

import UIKit

import RxCocoa
import RxSwift

class RecievedPopupViewController: BaseViewController {
    let mainView = WithdrawPopupView()
    let disposeBag = DisposeBag()
    var uid: String = ""
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        mainView.setPopupText("스터디를 수락할까요?", subTitle: "요청을 수락하면 채팅창에서 대화를 나눌 수 있어요.")
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    override func bindData() {
        mainView.okButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.requestMatchingAccept(uid: vc.uid)
            }
            .disposed(by: disposeBag)
        
        mainView.cancelButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.dismiss(animated: false)
            }
            .disposed(by: disposeBag)
    }
    
    func requestMatchingAccept(uid: String) {
        let api = SesacAPIRouter.studyAccept(uid: uid)
        SesacSignupAPIService.shared.requestStudyRequest(router: api) { [weak self] statusCode in
            print(statusCode)
            guard let self = self else { return }
            switch MatchingAcceptCode(rawValue: statusCode) {
            case .success:
                self.requestMyQueueState { data in
                    self.dismiss(animated: false) {
                        let chatVC = ChattingViewController()
                        chatVC.viewModel.data = data
                        guard let vc = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
                        vc.transViewController(ViewController: chatVC, type: .push)
                    }
                }
            case .alreadyMatching:
                self.dismiss(animated: false) {
                    guard let vc = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
                    vc.view.makeToast("이미 다른 새싹과 스터디를 함께 하는 중입니다.", position: .center)
                }
            case .stopUserRequest:
                self.dismiss(animated: false) {
                    guard let vc = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
                    vc.view.makeToast("상대방이 스터디 찾기를 그만두었습니다.", position: .center)
                }
            case .alreadyMatchingMe:
                self.dismiss(animated: false) {
                    guard let vc = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
                    vc.view.makeToast("앗! 누군가가 나의 스터디를 수락하였어요!", position: .center)
                }
            default:
                print(MatchingCode(rawValue: statusCode)!)
            }
        }
    }
    
    func requestMyQueueState(completion: @escaping (MyQueueState) -> Void) {
        let api = SesacAPIRouter.myQueueStateGet
        
        SesacSignupAPIService.shared.requestMyStateData(router: api) { response in
            switch response {
            case .success(let success):
                completion(success)
            case .failure(let error):
                print("error: \(error)")
                self.view.makeToast("error: \(error)", position: .center)
            }
        }
    }
}

enum MatchingAcceptCode: Int {
    case success = 200
    case alreadyMatching = 201
    case stopUserRequest = 202
    case alreadyMatchingMe = 203
    case firebaseTokenError = 401
    case nosignup = 406
    case serverError = 500
    case clientError = 501
}
