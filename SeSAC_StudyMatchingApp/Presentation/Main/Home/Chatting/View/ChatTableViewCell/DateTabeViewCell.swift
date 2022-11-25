//
//  ChattingHeaderView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/25.
//

import UIKit

import SnapKit

class DateTableViewCell: UITableViewCell {
    lazy var totalView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [dateView, matchedView])
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        return view
    }()
    
    lazy var dateView: UIView = {
        let view = UIView()
        view.backgroundColor = .sesacGray7
        view.layer.cornerRadius = 14
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 12)
        view.textColor = .white
        return view
    }()
    
    lazy var matchedView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var matchedTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
        view.textColor = .sesacGray7
        return view
    }()
    
    lazy var matchedSubTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.text = "채팅을 통해 약속을 정해보세요"
        view.textColor = .sesacGray6
        return view
    }()
    
    lazy var matchedImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "bell")
        view.backgroundColor = .clear
        view.tintColor = .sesacGray7
        return view
    }()
    
    lazy var matchedTitleStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [matchedImageView, matchedTitleLabel])
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
        setFirstMatched(false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        selectionStyle = .none
        
        self.addSubview(totalView)
        
        [dateView, matchedView].forEach {
            totalView.addSubview($0)
        }
        
        [matchedTitleStackView, matchedSubTitleLabel].forEach {
            matchedView.addSubview($0)
        }
        
        dateView.addSubview(dateLabel)
    }
    
    func setConstraints() {
        totalView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dateView.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(114)
            make.top.equalToSuperview().inset(16)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        matchedView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom)
//            make.height.equalTo(50)
            make.trailing.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalToSuperview()
        }
        
        matchedTitleStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        matchedImageView.snp.makeConstraints { make in
            make.height.width.equalTo(16)
        }
        
        matchedSubTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(matchedTitleStackView.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setFirstMatched(_ on: Bool) {
        matchedView.isHidden = !on
    }
}
