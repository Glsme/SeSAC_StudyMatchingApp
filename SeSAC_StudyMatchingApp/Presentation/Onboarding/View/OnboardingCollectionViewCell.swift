//
//  OnboardingCollectionViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

import SnapKit

final class OnboardingCollectionViewCell: BaseCollectionViewCell {
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 24)
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()
    
    lazy var illustImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    let onboardingImageList = [UIImage(named: OnboardingAssets.onboardingImg1.rawValue),
                               UIImage(named: OnboardingAssets.onboardingImg2.rawValue),
                               UIImage(named: OnboardingAssets.onboardingImg3.rawValue)]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [descriptionLabel, illustImageView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.bottom.lessThanOrEqualTo(illustImageView.snp.top)
        }
        
        illustImageView.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height).multipliedBy(0.75)
        }
    }
    
    public func setDescriptionLabel(indexPath: IndexPath) {
        let mediumFont = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 24)
        switch indexPath.item {
        case 0:
            let ment = OnboardingMents.firstOnboardingMent.rawValue
            let highlightMent = OnboardingMents.firstOnboardingHighlightMent.rawValue
            descriptionLabel.text = ment
            
            let attributedString = NSMutableAttributedString(string: ment)
            attributedString.addAttribute(.font, value: mediumFont ?? .boldSystemFont(ofSize: 24), range: (ment as NSString).range(of: highlightMent))
            attributedString.addAttribute(.foregroundColor, value: UIColor.sesacGreen, range: (ment as NSString).range(of: highlightMent))
            descriptionLabel.attributedText = attributedString
        case 1:
            let ment = OnboardingMents.secondOnboardingMent.rawValue
            let highlightMent = OnboardingMents.secondOnboardingHighlightMent.rawValue
            descriptionLabel.text = ment
            
            let attributedString = NSMutableAttributedString(string: ment)
            attributedString.addAttribute(.font, value: mediumFont ?? .boldSystemFont(ofSize: 24), range: (ment as NSString).range(of: highlightMent))
            attributedString.addAttribute(.foregroundColor, value: UIColor.sesacGreen, range: (ment as NSString).range(of: highlightMent))
            descriptionLabel.attributedText = attributedString
        case 2:
            descriptionLabel.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 24)
            descriptionLabel.text = OnboardingMents.thridOnboardingMent.rawValue
        default:
            break
        }
    }
    
    public func setIllustImageView(indexPath: IndexPath) {
        switch indexPath.item {
        case 0, 1, 2:
            illustImageView.image = onboardingImageList[indexPath.item]
        default:
            break
        }
    }
}
