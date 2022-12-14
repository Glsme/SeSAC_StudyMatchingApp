//
//  OnboardingViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

import RxCocoa
import RxSwift

final class OnboardingViewController: BaseViewController {
    let mainView = OnboardingView()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        mainView.onboardingCollectionView.delegate = self
        mainView.onboardingCollectionView.dataSource = self
        mainView.onboardingCollectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier)
        
        
        mainView.pageControl.rx.controlEvent(.valueChanged)
            .withUnretained(self)
            .bind { (vc, _) in
                let currentPage = vc.mainView.pageControl.currentPage
                vc.mainView.onboardingCollectionView.scrollToItem(at: IndexPath(item: currentPage, section: 0), at: .right, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func bindData() {
        mainView.startButton.rx.tap
            .withUnretained(self)
            .subscribe { (vc, _) in
                UserManager.first = false
                let certificationVC = CertificationRequestViewController()
                let naviVC = UINavigationController(rootViewController: certificationVC)
                naviVC.modalTransitionStyle = .crossDissolve
//                vc.dismiss(animated: false)
                vc.transViewController(ViewController: naviVC, type: .presentFullscreen)
            }
            .disposed(by: disposeBag)
    }
}

extension OnboardingViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        mainView.pageControl.currentPage = Int(scrollView.contentOffset.x / width)
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setDescriptionLabel(indexPath: indexPath)
        cell.setIllustImageView(indexPath: indexPath)
        
        return cell
    }
}
