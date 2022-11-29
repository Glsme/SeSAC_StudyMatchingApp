//
//  YourChatTableViewCell.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/23.
//

import UIKit

import SnapKit

class YourChatTableViewCell: UITableViewCell {
    lazy var talkBubble: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.sesacGray4.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var talkLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 12)
        view.textColor = .sesacGray6
        return view
    }()
    
    let timeFormatter: DateFormatter = {
        let timeForatter = DateFormatter()
        timeForatter.dateFormat = "a HH:mm"
        timeForatter.timeZone = TimeZone(identifier: "UTC+18")
        timeForatter.locale = Locale(identifier: "ko_KR")
        return timeForatter
    }()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d a HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "UTC+18")
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        selectionStyle = .none
        talkBubble.addSubview(talkLabel)
        
        [talkBubble, timeLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints() {
        talkBubble.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(16)
            make.trailing.lessThanOrEqualTo(safeAreaLayoutGuide.snp.trailing).offset(-100)
        }
        
        talkLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(talkBubble.snp.trailing).offset(8)
            make.bottom.equalTo(talkBubble.snp.bottom)
        }
    }
    
    func setTimeText(_ text: String) {
        guard let date = text.toDate() else { return }
        
        let dateComponent = Calendar.current.dateComponents([.day], from: date)
        let currentDateComponent = Calendar.current.dateComponents([.day], from: Date())
        
//        print(dateComponent, currentDateComponent)
        
        if dateComponent == currentDateComponent {
            timeLabel.text = timeFormatter.string(from: date)
        } else {
            timeLabel.text = dateFormatter.string(from: date)
        }
    }
}
