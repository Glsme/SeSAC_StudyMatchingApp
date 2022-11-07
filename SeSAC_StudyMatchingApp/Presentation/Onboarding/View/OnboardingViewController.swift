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
        mainView.onboardingCollectionView.dataSource = self
        mainView.onboardingCollectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier)
    }
    
    override func bindData() {
        mainView.startButton.rx.tap
            .withUnretained(self)
            .subscribe { (vc, _) in
                UserDefaults.standard.setValue(true, forKey: "first")
                let certificationVC = CertificationRequestViewController()
                let naviVC = UINavigationController(rootViewController: certificationVC)
                naviVC.modalPresentationStyle = .fullScreen
                naviVC.modalTransitionStyle = .crossDissolve
                vc.dismiss(animated: false)
                vc.present(naviVC, animated: true)
            }
            .disposed(by: disposeBag)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        mainView.pageControl.currentPage = Int(scrollView.contentOffset.x / width)
    }
}
