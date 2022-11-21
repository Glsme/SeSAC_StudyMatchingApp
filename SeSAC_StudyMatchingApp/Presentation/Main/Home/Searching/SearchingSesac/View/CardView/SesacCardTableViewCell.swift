//
//  AroundSesacTableViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/21.
//

import UIKit

import SnapKit

class SesacCardTableViewCell: UITableViewCell {
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
}
