//
//  BirthView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import UIKit

import SnapKit

final class BirthView: UserConfigureView {
    let yearTextField: BlackHighlightTextField = {
        let view = BlackHighlightTextField()
        view.textField.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.setPlaceHolder("1990")
        view.textField.isEnabled = false
        return view
    }()
    
    let monthTextField: BlackHighlightTextField = {
        let view = BlackHighlightTextField()
        view.setStyle(font: UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14), keyboardType: .default)
        view.setPlaceHolder("1")
        view.textField.isEnabled = false
        return view
    }()
    
    let dayTextField: BlackHighlightTextField = {
        let view = BlackHighlightTextField()
        view.setStyle(font: UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14), keyboardType: .default)
        view.setPlaceHolder("1")
        view.textField.isEnabled = false
        return view
    }()
    
    let yearLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 16)
        view.text = "년"
        return view
    }()
    
    let monthLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 16)
        view.text = "월"
        return view
    }()
    
    let dayLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 16)
        view.text = "일"
        return view
    }()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy M d"
        return formatter
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
        
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        components.year = 0
        let maxDate = calendar.date(byAdding: components, to: currentDate)!
        
        components.year = -150
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        
        return datePicker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        super.configureUI()
        
        [yearTextField, yearLabel, monthTextField, monthLabel, dayTextField, dayLabel, datePicker].forEach {
            self.addSubview($0)
        }
        
        descriptionLabel.text = SignupMents.birthDescription.rawValue
        requestButton.setTitle(SignupMents.nextButton.rawValue, for: .normal)
        datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        datePicker.backgroundColor = .sesacGray4
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        yearTextField.snp.makeConstraints { make in
            make.width.equalTo(requestButton.snp.width).multipliedBy(0.21)
            make.trailing.equalTo(yearLabel.snp.leading).offset(-4)
            make.height.equalTo(41) // TextField = 40, Line = 1
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.75)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.centerY.equalTo(yearTextField.snp.centerY)
            make.trailing.equalTo(monthTextField.snp.leading).offset(-20)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.width.equalTo(requestButton.snp.width).multipliedBy(0.21)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX).multipliedBy(0.95)
            make.height.equalTo(41) // TextField = 40, Line = 1
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.75)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.centerY.equalTo(monthTextField.snp.centerY)
            make.leading.equalTo(monthTextField.snp.trailing).offset(4)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.width.equalTo(requestButton.snp.width).multipliedBy(0.21)
            make.leading.equalTo(monthLabel.snp.trailing).offset(20)
            make.height.equalTo(41) // TextField = 40, Line = 1
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.75)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.centerY.equalTo(dayTextField.snp.centerY)
            make.leading.equalTo(dayTextField.snp.trailing).offset(4)
        }
        
        datePicker.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let dateArray = formatter.string(from: datePicker.date).components(separatedBy: " ")
        yearTextField.textField.text = dateArray[0]
        monthTextField.textField.text = dateArray[1]
        dayTextField.textField.text = dateArray[2]
        
    }
}
