//
//  SearchTabView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/21.
//

import UIKit

import SnapKit

class NoSearchView: BaseView {
    lazy var changeButton: GreenSelectedButton = {
        let view = GreenSelectedButton()
        view.setSelectedStyle(true)
        view.setTitle("스터디 변경하기", for: .normal)
        return view
    }()
    
    lazy var reloadButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.sesacGreen.cgColor
        view.layer.borderWidth = 1
        view.setImage(UIImage(named: SearchAssets.reload.rawValue), for: .normal)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var noCardView = UIView()
    
    lazy var graySesacImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: SearchAssets.graySesac.rawValue))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 20)
        view.text = "아직 받은 요청이 없어요ㅠ"
        return view
    }()
    
    lazy var subTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.text = "스터디를 변경하거나 조금만 더 기다려주세요!"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
    }
    
    override func configureUI() {
        [changeButton, reloadButton, noCardView].forEach {
            self.addSubview($0)
        }
        
        [graySesacImageView, titleLabel, subTitleLabel].forEach {
            noCardView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        noCardView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(safeAreaLayoutGuide)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.8)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.25)
        }
        
        graySesacImageView.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.top.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(graySesacImageView.snp.centerX)
            make.bottom.equalTo(subTitleLabel.snp.top).offset(-8)
        }
        
        changeButton.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(16)
            make.bottom.equalTo(reloadButton.snp.bottom)
            make.height.equalTo(reloadButton.snp.height)
            make.trailing.equalTo(reloadButton.snp.leading).offset(-8)
        }
        
        reloadButton.snp.makeConstraints { make in
            make.height.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.128)
            make.bottom.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
    func setRequestView(_ hidden: Bool) {
        noCardView.isHidden = true
        changeButton.isHidden = true
        reloadButton.isHidden = true
    }
}
