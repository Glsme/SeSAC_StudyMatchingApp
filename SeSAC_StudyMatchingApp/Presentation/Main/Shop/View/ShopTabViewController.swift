//
//  ShopViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/30.
//

import UIKit

import SnapKit
import Tabman
import Pageboy

class ShopTabViewController: TabmanViewController {
    let characterVC = CharacterViewController()
    let backgroundVC = BackgroundViewController()
    let characterView = ShopBaseView()
    
    private var viewControllers: [UIViewController] = []
    
    override func loadView() {
        self.view = characterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        
        navigationItem.title = "새싹샵"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14) ?? UIFont.systemFont(ofSize: 14)]
        
        viewControllers.append(characterVC)
        viewControllers.append(backgroundVC)
        
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
        
        bar.backgroundView.style = .clear
        addBar(bar, dataSource: self, at: .custom(view: characterView.barView, layout: nil))
    }
}

extension ShopTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
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
            return TMBarItem(title: "새싹")
        case 1:
            return TMBarItem(title: "배경")
        default:
            return TMBarItem(title: "Page")
        }
    }
}
