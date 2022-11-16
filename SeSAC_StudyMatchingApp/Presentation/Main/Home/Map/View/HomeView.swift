//
//  HomeView.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/11.
//

import MapKit
import UIKit

import SnapKit

final class HomeView: BaseView {
    lazy var mapView = MKMapView()
    lazy var searchButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        view.layer.cornerRadius = 32
        view.setImage(UIImage(named: HomeAssets.search.rawValue), for: .normal)
        return view
    }()
    
    lazy var allButton: UIButton = {
        let view = UIButton()
        view.setTitle("전체", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
        view.backgroundColor = .sesacGreen
        return view
    }()
    
    lazy var manButton: UIButton = {
        let view = UIButton()
        view.setTitle("남자", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var womanButton: UIButton = {
        let view = UIButton()
        view.setTitle("여자", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var gpsButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: HomeAssets.place.rawValue), for: .normal)
        view.tintColor = .black
        view.titleLabel?.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [allButton, manButton, womanButton])
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var pinImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.image = UIImage(named: HomeAssets.mapMarker.rawValue)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureUI() {
        [mapView, searchButton, stackView, gpsButton, pinImageView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.17)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.top.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        allButton.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.height.width.equalTo(48)
        }
        
        manButton.snp.makeConstraints { make in
            make.top.equalTo(allButton.snp.bottom)
            make.height.width.equalTo(allButton.snp.width)
        }
        
        womanButton.snp.makeConstraints { make in
            make.top.equalTo(manButton.snp.bottom)
            make.height.width.equalTo(allButton.snp.width)
            make.bottom.equalToSuperview()
        }
        
        gpsButton.snp.makeConstraints { make in
            make.leading.equalTo(stackView.snp.leading)
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.height.width.equalTo(48)
        }
        
        pinImageView.snp.makeConstraints { make in
            make.width.height.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.128)
            make.center.equalTo(safeAreaLayoutGuide.snp.center)
        }
    }
    
    func setAllButtonSelectedStyle(_ bool: Bool) {
        if bool {
            allButton.setTitleColor(.white, for: .normal)
            allButton.backgroundColor = .sesacGreen
            allButton.titleLabel?.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
        } else {
            allButton.setTitleColor(.black, for: .normal)
            allButton.backgroundColor = .white
            allButton.titleLabel?.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        }
    }
    
    func setManButtonSelectedStyle(_ bool: Bool) {
        if bool {
            manButton.setTitleColor(.white, for: .normal)
            manButton.backgroundColor = .sesacGreen
            manButton.titleLabel?.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
        } else {
            manButton.setTitleColor(.black, for: .normal)
            manButton.backgroundColor = .white
            manButton.titleLabel?.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        }
    }
    
    func setWomanButtonSelectedStyle(_ bool: Bool) {
        if bool {
            womanButton.setTitleColor(.white, for: .normal)
            womanButton.backgroundColor = .sesacGreen
            allButton.titleLabel?.font = UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14)
        } else {
            womanButton.setTitleColor(.black, for: .normal)
            womanButton.backgroundColor = .white
            womanButton.titleLabel?.font = UIFont(name: Fonts.notoSansKRRegular.rawValue, size: 14)
        }
    }
}
