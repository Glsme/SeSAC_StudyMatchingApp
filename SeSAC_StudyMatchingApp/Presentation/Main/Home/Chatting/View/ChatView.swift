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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [chatTableView, userInputView].forEach {
            self.addSubview($0)
        }
        
        [inputTextView, sendButton].forEach {
            userInputView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        chatTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
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
}
