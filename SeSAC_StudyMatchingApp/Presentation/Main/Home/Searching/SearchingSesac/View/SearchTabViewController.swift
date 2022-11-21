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
    let mainView = SearchTabView()
    let disposebag = DisposeBag()
    let viewModel = SearchTabViewModel()
    
    let aroundVC = AroundSesacViewController()
    let recivedVC = RecivedViewController()
    
    let backButton = UIBarButtonItem(image: UIImage(named: CommonAssets.backButton.rawValue), style: .done, target: AroundSesacViewController.self, action: nil)
    let stopButton = UIBarButtonItem(title: "찾기중단", style: .done, target: AroundSesacViewController.self, action: nil)
    
    private var viewControllers: [UIViewController] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindData()
    }
    
    func configureUI() {
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = stopButton
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        viewControllers.append(aroundVC)
        viewControllers.append(recivedVC)
        aroundVC.viewModel.searchedData = viewModel.searchData
        
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
        mainView.reloadButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                print("reload")
            }
            .disposed(by: disposebag)
        
        mainView.changeButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                print("change")
                vc.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposebag)
        
        stopButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.requestStopMatching { statusCode in
                    switch stopMatchingCode(rawValue: statusCode) {
                    case .success:
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
}

extension SearchTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
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
