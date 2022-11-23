//
//  SearchTabViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/21.
//

import UIKit

import Tabman
import Pageboy
import RxCocoa
import RxSwift

final class SearchTabViewController: TabmanViewController {
    let disposebag = DisposeBag()
    let viewModel = SearchTabViewModel()
    
    let aroundVC = AroundSesacViewController()
    let recivedVC = RecivedViewController()
    
    let backButton = UIBarButtonItem(image: UIImage(named: CommonAssets.backButton.rawValue), style: .done, target: AroundSesacViewController.self, action: nil)
    let stopButton = UIBarButtonItem(title: "찾기중단", style: .done, target: AroundSesacViewController.self, action: nil)
    
    private var viewControllers: [UIViewController] = []
    var timerDisposable: Disposable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        bindData()
        resetAndGoTimer()
    }
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = false
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = stopButton
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        navigationItem.title = "새싹 찾기"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14) ?? UIFont.systemFont(ofSize: 14)]
        
        viewControllers.append(aroundVC)
        viewControllers.append(recivedVC)
        aroundVC.viewModel.searchedData = viewModel.searchData
        recivedVC.viewModel.searchedData = viewModel.searchData
        
        aroundVC.viewModel.lat = viewModel.lat
        recivedVC.viewModel.lat = viewModel.lat
        
        aroundVC.viewModel.long = viewModel.long
        recivedVC.viewModel.long = viewModel.long
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.contentMode = .fit
        bar.indicator.tintColor = .sesacGreen
        bar.buttons.customize { button in
            button.tintColor = .sesacGray6
            button.selectedTintColor = .sesacGreen
            button.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14) ?? UIFont.systemFont(ofSize: 14)
        }
        
        bar.backgroundView.style = .blur(style: .regular)
        
        addBar(bar, dataSource: self, at: .top)
    }
    
    func bindData() {        
        stopButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.requestStopMatching { statusCode in
                    switch stopMatchingCode(rawValue: statusCode) {
                    case .success:
                        vc.timerDisposable?.dispose()
                        guard let vcs = vc.navigationController?.viewControllers else { return }
                        
                        for vc in vcs {
                            if let rootVC = vc as? HomeViewController {
                                vc.navigationController?.popToViewController(rootVC, animated: true)
                            }
                        }
                    case .alreadyStop:
                        vc.view.makeToast("이미 찾기가 중단되었습니다.", position: .center)
                    default:
                        print(statusCode)
                    }
                }
            }
            .disposed(by: disposebag)
        
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
            .disposed(by: disposebag)
    }
    
    private func resetAndGoTimer() {
        timerDisposable?.dispose()
        timerDisposable = Observable<Int>
            .timer(.seconds(1), period: .seconds(5), scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
            .withUnretained(self)
            .subscribe(onNext: { (vc, _) in
                print("timer run")
                vc.viewModel.requestMyQueueState { result in
                    vc.timerDisposable?.dispose()
                    vc.view.makeToast("\(result.matchedNick ?? "새싹")님과 매칭되셨습니다.\n잠시 후 채팅방으로 이동합니다.", duration: 1) { didTap in
                        print("채팅방 들어간다~")
                        let nextVC = ChattingViewController()
                        nextVC.viewModel.data = result
                        vc.transViewController(ViewController: nextVC, type: .push)
                    }
                }
            })
    }
}

extension SearchTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        timerDisposable?.dispose()
        
        viewModel.requsetSearchData(lat: viewModel.lat, long: viewModel.long) { [weak self] response in
            guard let self = self else{ return }
            switch response {
            case .success(let success):
                print("success search")
                self.aroundVC.viewModel.lat = self.viewModel.lat
                self.aroundVC.viewModel.long = self.viewModel.long
                self.recivedVC.viewModel.lat = self.viewModel.lat
                self.recivedVC.viewModel.long = self.viewModel.long
                
                self.aroundVC.viewModel.searchedData = success
                self.recivedVC.viewModel.searchedData = success
            case .failure(let error):
                print("error \(error)")
            }
        }
        
        resetAndGoTimer()
        
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "주변 새싹")
        case 1:
            return TMBarItem(title: "받은 요청")
        default:
            return TMBarItem(title: "Page")
        }
    }
}
