//
//  CharacterViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/30.
//

import UIKit

final class CharacterViewController: BaseViewController {
    let mainView = CharacterView()
    let viewModel = ShopSubViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .sesacFocus
    }
    
    override func configureUI() {
        mainView.characterCollectionView.delegate = self
        mainView.characterCollectionView.dataSource = self
    }
}

extension CharacterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell() }
       
        cell.characterImageView.image = UIImage(named: viewModel.setCharacterImage(index: indexPath.item))
        cell.titleLabel.text = viewModel.setCharacterTitle(index: indexPath.item)
        cell.descriptionLabel.text = viewModel.setCharacterDescription(index: indexPath.item)
        cell.buyButton.setTitle("1,200", for: .normal)
        cell.buyButton.setEnabledButton(true)
        return cell
    }
    
    
}
