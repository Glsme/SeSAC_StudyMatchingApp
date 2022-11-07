//
//  OnboardingViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

final class OnboardingViewController: BaseViewController {
    let mainView = OnboardingView()
    let viewModel = OnboardingViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIFont.familyNames.sorted().forEach { familyName in
            print("*** \(familyName) ***")
            UIFont.fontNames(forFamilyName: familyName).forEach { fontName in
                print("\(fontName)")
            }
            print("---------------------")
        }
    }
    
    override func configureUI() {
        mainView.onboardingCollectionView.delegate = self
        mainView.onboardingCollectionView.dataSource = self
        mainView.onboardingCollectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier)
    }
}

extension OnboardingViewController: UICollectionViewDelegate {
    
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setDescriptionLabel(indexPath: indexPath)
        cell.illustImageView.image = UIImage(named: Assets.onboardingImg1.rawValue)
        
        return cell
    }
}
