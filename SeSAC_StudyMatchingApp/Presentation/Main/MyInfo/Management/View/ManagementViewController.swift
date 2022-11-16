//
//  ManagementViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/14.
//

import UIKit

import SnapKit
import RxDataSources
import RxSwift
import RxGesture

class ManagementViewController: BaseViewController {
    let mainView = ManagementView()
    let viewModel = ManagementViewModel()
    let disposeBag = DisposeBag()
    var cardToggle: Bool = true
    
    let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: ManagementViewController.self, action: nil)
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        // Profile image
        let profile = viewModel.setProfileImage()
        mainView.cardView.backgroundImageView.image = UIImage(named: profile[0])
        mainView.cardView.profileImageView.image = UIImage(named: profile[1])
        
        navigationItem.title = "정보 관리"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.notoSansKRMedium.rawValue, size: 14) ?? UIFont.systemFont(ofSize: 14)]
        navigationItem.rightBarButtonItem = saveButton
        saveButton.tintColor = .black
        
        
        mainView.cardView.titleView.isHidden = cardToggle
        
        guard let userInfo = try? viewModel.userInfo.value() else { return }
        dump(userInfo)
        print(userInfo.searchable, "!!!!!!!!")

        mainView.cardView.nicknameView.nameLabel.text = userInfo.nick
        mainView.ageView.ageSlider.value = [CGFloat(userInfo.ageMin), CGFloat(userInfo.ageMax)]
        mainView.ageView.ageLabel.text = "\(userInfo.ageMin) - \(userInfo.ageMax)"
        setSesacTitleColor(userInfo: userInfo)
        setGenderColor(userInfo: userInfo)
        mainView.studyView.studyTextField.textField.text = userInfo.study
        setPermitPhoneSearching(userInfo: userInfo)
    }
    
    override func bindData() {
        view.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        mainView.cardView.nicknameView.moreButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.cardToggle.toggle()
                print("tap")
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
                    vc.mainView.cardView.titleView.isHidden = vc.cardToggle
                }
                
                if vc.cardToggle {
                    vc.mainView.cardView.nicknameView.moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
                } else {
                    vc.mainView.cardView.nicknameView.moreButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
                }
            }
            .disposed(by: disposeBag)
        
        mainView.ageView.ageSlider.rx.controlEvent(.valueChanged)
            .withUnretained(self)
            .bind { (vc, _) in
                let value = vc.mainView.ageView.ageSlider.value
                vc.mainView.ageView.ageLabel.text = "\(Int(value[0])) - \(Int(value[1]))"
            }
            .disposed(by: disposeBag)
        
        mainView.genderView.manButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                if vc.mainView.genderView.manButton.backgroundColor == .white {
                    vc.mainView.genderView.manButton.setSelectedStyle(true)
                    vc.mainView.genderView.womanButton.setSelectedStyle(false)
                }
            }
            .disposed(by: disposeBag)
        
        mainView.genderView.womanButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                if vc.mainView.genderView.womanButton.backgroundColor == .white {
                    vc.mainView.genderView.manButton.setSelectedStyle(false)
                    vc.mainView.genderView.womanButton.setSelectedStyle(true)
                }
            }
            .disposed(by: disposeBag)
        
        saveButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.readyToSaveData()
                vc.viewModel.requsetUpdateMyPage {
                    vc.navigationController?.popViewController(animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func readyToSaveData() {
        let searchable: Int = mainView.phoneView.permitSwitch.isOn ? 1 : 0
        let ageGroup: [CGFloat] = mainView.ageView.ageSlider.value
        let gender: Int =  mainView.genderView.manButton.backgroundColor == .sesacGreen ? 1 : 0
        let study = mainView.studyView.studyTextField.textField.text ?? ""
        
        viewModel.mypageUpdate = MypageUpdate(searchable: searchable,
                                              ageMin: Int(ageGroup[0]),
                                              ageMax: Int(ageGroup[1]),
                                              gender: gender,
                                              study: study)
    }
    
    func setSesacTitleColor(userInfo: SeSACInfo) {
        let buttons = mainView.cardView.titleView
        let buttonArray = [buttons.firstButton, buttons.secondButton, buttons.thirdButton, buttons.fourthButton, buttons.fifthButton, buttons.sixthButton]
        
        for index in 0..<buttonArray.count {
            if userInfo.reputation[index] > 0 {
                buttonArray[index].setSelectedStyle(true)
            } else {
                buttonArray[index].setSelectedStyle(false)
            }
        }
        
    }
    
    func setGenderColor(userInfo: SeSACInfo) {
        if userInfo.gender == 0 {
            mainView.genderView.womanButton.setSelectedStyle(true)
            mainView.genderView.manButton.setSelectedStyle(false)
        } else if userInfo.gender == 1 {
            mainView.genderView.womanButton.setSelectedStyle(false)
            mainView.genderView.manButton.setSelectedStyle(true)
        }
    }
    
    func setPermitPhoneSearching(userInfo: SeSACInfo) {
        if userInfo.searchable == 1 {
            mainView.phoneView.permitSwitch.isOn = true
        } else if userInfo.searchable == 0 {
            mainView.phoneView.permitSwitch.isOn = false
        }
    }
}
