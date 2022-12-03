//
//  AroundSesacTableViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/21.
//

import UIKit

import SnapKit
import RxCocoa
import RxSwift

final class SesacCardTableViewCell: UITableViewCell {
    lazy var cardView = ProfileCardView()
    lazy var requsetButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .sesacError
        view.setTitle("요청하기", for: .normal)
        view.titleLabel?.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 8
        return view
    }()
    
    var hiddenFlag = true
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.contentView.addSubview(cardView)
        self.contentView.addSubview(requsetButton)
        selectionStyle = .none
        
        cardView.titleView.studyCollectionView.isHidden = false
    }
    
    func setConstraints() {
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        requsetButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(28)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
    }
    
    func setRequestButtonType(request: Bool) {
        if request {
            requsetButton.setTitle("요청하기", for: .normal)
            requsetButton.backgroundColor = .sesacError
        } else {
            requsetButton.setTitle("수락하기", for: .normal)
            requsetButton.backgroundColor = .sesacSuccess
        }
    }
    
    func setHidden(_ bool: Bool) {
        cardView.titleView.isHidden = bool
    }
    
    func setImage(_ backgroundImage: Int, _ profileImage: Int) {
        switch backgroundImage {
        case 0:
            cardView.backgroundImageView.image = UIImage(named: SesacBGAssets.sesacBG1.rawValue)
        case 1:
            cardView.backgroundImageView.image = UIImage(named: SesacBGAssets.sesacBG2.rawValue)
        case 2:
            cardView.backgroundImageView.image = UIImage(named: SesacBGAssets.sesacBG3.rawValue)
        case 3:
            cardView.backgroundImageView.image = UIImage(named: SesacBGAssets.sesacBG4.rawValue)
        case 4:
            cardView.backgroundImageView.image = UIImage(named: SesacBGAssets.sesacBG5.rawValue)
        case 5:
            cardView.backgroundImageView.image = UIImage(named: SesacBGAssets.sesacBG6.rawValue)
        case 6:
            cardView.backgroundImageView.image = UIImage(named: SesacBGAssets.sesacBG7.rawValue)
        case 7:
            cardView.backgroundImageView.image = UIImage(named: SesacBGAssets.sesacBG8.rawValue)
        case 8:
            cardView.backgroundImageView.image = UIImage(named: SesacBGAssets.sesacBG9.rawValue)
        default:
            cardView.backgroundImageView.image = UIImage(named: SesacBGAssets.sesacBG1.rawValue)
        }
        
        switch profileImage {
        case 0:
            cardView.profileImageView.image = UIImage(named: SesacCharaterAssets.sesacFace1.rawValue)
        case 1:
            cardView.profileImageView.image = UIImage(named: SesacCharaterAssets.sesacFace2.rawValue)
        case 2:
            cardView.profileImageView.image = UIImage(named: SesacCharaterAssets.sesacFace3.rawValue)
        case 3:
            cardView.profileImageView.image = UIImage(named: SesacCharaterAssets.sesacFace4.rawValue)
        case 4:
            cardView.profileImageView.image = UIImage(named: SesacCharaterAssets.sesacFace5.rawValue)
        default:
            cardView.profileImageView.image = UIImage(named: SesacCharaterAssets.sesacFace1.rawValue)
        }
    }
    
    func setSesacTitleColor(_ sesacTitle: [Int]) {
        let buttons = cardView.titleView
        let buttonArray = [buttons.firstButton, buttons.secondButton, buttons.thirdButton, buttons.fourthButton, buttons.fifthButton, buttons.sixthButton]
        
        for count in 0..<buttonArray.count {
            if sesacTitle[count] > 0 {
                buttonArray[count].setSelectedStyle(true)
            }
        }
    }
    
    func configureDataSource(studies: [String]) {
        let tagCellRegistration = UICollectionView.CellRegistration<RecommendCell, String> { cell, indexPath, itemIdentifier in
            
            cell.titleLabel.text = itemIdentifier
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) { headerView, elementKind, indexPath in
            
            var configuration = headerView.defaultContentConfiguration()
            configuration.text = "하고 싶은 스터디"
            configuration.textProperties.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 12) ?? UIFont.systemFont(ofSize: 12)
            configuration.textProperties.color = .black
            headerView.contentConfiguration = configuration
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: cardView.titleView.studyCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: tagCellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
        
        dataSource.supplementaryViewProvider = { [weak self] (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            return self?.cardView.titleView.studyCollectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(studies, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
