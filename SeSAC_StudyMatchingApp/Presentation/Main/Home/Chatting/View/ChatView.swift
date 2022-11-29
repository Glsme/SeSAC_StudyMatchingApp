//
//  ChatView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/23.
//

import UIKit

import SnapKit

class ChatView: BaseView {
    lazy var chatTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(DateTableViewCell.self, forCellReuseIdentifier: DateTableViewCell.reuseIdentifier)
        view.register(YourChatTableViewCell.self, forCellReuseIdentifier: YourChatTableViewCell.reuseIdentifier)
        view.register(MyChatTableViewCell.self, forCellReuseIdentifier: MyChatTableViewCell.reuseIdentifier)
        //        view.estimatedRowHeight = 100
        view.rowHeight = UITableView.automaticDimension
        view.separatorColor = .white
        return view
    }()
    
    lazy var userInputView: UIView = {
        let view = UIView()
        view.backgroundColor = .sesacGray1
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var inputTextView: UITextView = {
        let view = UITextView()
        view.isScrollEnabled = false
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var sendButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: ChattingAssets.sendIcon.rawValue), for: .normal)
        view.clipsToBounds = true
        return view
    }()
    
    lazy var topBGView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    lazy var reportButton: UIButton = {
        let view = UIButton()
        
        var config = UIButton.Configuration.tinted()
        var titleAttr = AttributedString.init("새싹 신고")
        titleAttr.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
        titleAttr.foregroundColor = .black
        config.attributedTitle = titleAttr
        
        config.image = UIImage(named: ChattingAssets.reportIcon.rawValue)
        config.imagePadding = 5
        config.imagePlacement = .top
        config.baseBackgroundColor = .white
        
        view.tintColor = .black
        view.configuration = config
        view.backgroundColor = .white
        return view
    }()
    
    lazy var cancelButton: UIButton = {
        let view = UIButton()
        
        var config = UIButton.Configuration.tinted()
        var titleAttr = AttributedString.init("스터디 취소")
        titleAttr.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
        titleAttr.foregroundColor = .black
        config.attributedTitle = titleAttr
        
        config.image = UIImage(named: ChattingAssets.cancelButton.rawValue)
        config.imagePadding = 5
        config.imagePlacement = .top
        config.baseBackgroundColor = .white
        
        view.tintColor = .black
        view.configuration = config
        view.backgroundColor = .white
        return view
    }()
    
    lazy var writeButton: UIButton = {
        let view = UIButton()
        
        var config = UIButton.Configuration.tinted()
        var titleAttr = AttributedString.init("리뷰 등록")
        titleAttr.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
        titleAttr.foregroundColor = .black
        config.attributedTitle = titleAttr
        
        config.image = UIImage(named: ChattingAssets.write.rawValue)
        config.imagePadding = 5
        config.imagePlacement = .top
        config.baseBackgroundColor = .white
        
        view.tintColor = .black
        view.configuration = config
        view.backgroundColor = .white
        return view
    }()
    
    lazy var topButtonStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [reportButton, cancelButton, writeButton])
        view.backgroundColor = .white
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [chatTableView, userInputView, topBGView, topButtonStackView].forEach {
            self.addSubview($0)
        }
        
        topBGView.isHidden = true
        
        [inputTextView, sendButton].forEach {
            userInputView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        topBGView.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        topButtonStackView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.top)
            make.height.equalTo(72)
        }
        
        chatTableView.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(userInputView.snp.top).inset(16)
        }
        
        userInputView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        inputTextView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(14)
            make.leading.equalToSuperview().inset(12)
            make.height.greaterThanOrEqualTo(26)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        sendButton.snp.makeConstraints { make in
            make.centerY.equalTo(inputTextView.snp.centerY)
            make.width.height.equalTo(24)
            make.trailing.equalToSuperview().inset(14)
        }
    }
    
    func setButtonisSendMode(_ on: Bool) {
        if on {
            sendButton.setImage(UIImage(named: ChattingAssets.sendFillIcon.rawValue), for: .normal)
        } else {
            sendButton.setImage(UIImage(named: ChattingAssets.sendIcon.rawValue), for: .normal)
        }
    }
    
    func setMatchedButtonText(_ matched: Bool) {
        if matched {
            var config = UIButton.Configuration.tinted()
            var titleAttr = AttributedString.init("스터디 취소")
            titleAttr.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
            titleAttr.foregroundColor = .black
            config.attributedTitle = titleAttr
            
            config.image = UIImage(named: ChattingAssets.cancelButton.rawValue)
            config.imagePadding = 5
            config.imagePlacement = .top
            config.baseBackgroundColor = .white
            
            cancelButton.configuration = config
        } else {
            var config = UIButton.Configuration.tinted()
            var titleAttr = AttributedString.init("스터디 종료")
            titleAttr.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
            titleAttr.foregroundColor = .black
            config.attributedTitle = titleAttr
            
            config.image = UIImage(named: ChattingAssets.cancelButton.rawValue)
            config.imagePadding = 5
            config.imagePlacement = .top
            config.baseBackgroundColor = .white
            
            cancelButton.configuration = config
        }
    }
}
