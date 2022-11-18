//
//  HomeViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/11.
//

import CoreLocation
import MapKit
import UIKit

import RxCocoa
import RxSwift

final class HomeViewController: BaseViewController {
    let mainView = HomeView()
    let viewModel = MainViewModel()
    let disposeBag = DisposeBag()
    
    let locationManager = CLLocationManager()
    var locationStatus = false
    let defaultCoordinate = CLLocationCoordinate2D(latitude: 37.517857, longitude: 126.887159)
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mainView.mapView.delegate = self
        checkUserDeviceLocationServiceAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
        searchData()
    }
    
    func searchData() {
//        locationManager.startUpdatingLocation()
//        guard let coordinate = locationManager.location?.coordinate else { return }
//        locationManager.stopUpdatingLocation()
        
        // Test Code : 영등포 캠퍼스 옆의 좌표
        let coordinate = CLLocationCoordinate2D(latitude: defaultCoordinate.latitude, longitude: defaultCoordinate.longitude)
        
        viewModel.requsetSearchData(lat: coordinate.latitude, long: coordinate.longitude) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let success):
                success.fromQueueDB.forEach { coordinate in
                    let lat = Double(coordinate.lat)
                    let long = Double(coordinate.long)
                    self.setUserRegionAndAnnotation(lat: lat, long: long)
                }
                
                success.fromQueueDBRequested.forEach { coordinate in
                    let lat = Double(coordinate.lat)
                    let long = Double(coordinate.long)
                    self.setUserRegionAndAnnotation(lat: lat, long: long)
                }
                
                dump(success)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setUserRegionAndAnnotation(lat: Double, long: Double) {
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 700, longitudinalMeters: 700)
        mainView.mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
//        annotation.
//        annotation.title = "현재 위치"
        
        mainView.mapView.addAnnotation(annotation)
    }
    
    override func bindData() {
        mainView.allButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                if vc.mainView.allButton.backgroundColor != .sesacGreen {
                    vc.mainView.setManButtonSelectedStyle(false)
                    vc.mainView.setWomanButtonSelectedStyle(false)
                    vc.mainView.setAllButtonSelectedStyle(true)
                }
            }
            .disposed(by: disposeBag)
        
        mainView.manButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                if vc.mainView.manButton.backgroundColor != .sesacGreen {
                    vc.mainView.setManButtonSelectedStyle(true)
                    vc.mainView.setWomanButtonSelectedStyle(false)
                    vc.mainView.setAllButtonSelectedStyle(false)
                }
            }
            .disposed(by: disposeBag)
        
        mainView.womanButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                if vc.mainView.womanButton.backgroundColor != .sesacGreen {
                    vc.mainView.setAllButtonSelectedStyle(false)
                    vc.mainView.setManButtonSelectedStyle(false)
                    vc.mainView.setWomanButtonSelectedStyle(true)
                }
            }
            .disposed(by: disposeBag)
        
        mainView.gpsButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                if vc.locationStatus {
                    vc.locationManager.startUpdatingLocation()
                    guard let coordinate = vc.locationManager.location?.coordinate else { return }
                    vc.setUserRegionAndAnnotation(lat: coordinate.latitude, long: coordinate.longitude)
                    vc.locationManager.stopUpdatingLocation()
                } else {
                    vc.showAlert(message: "위치 권한을 허용해 주세요.")
                }
            }
            .disposed(by: disposeBag)
        
        mainView.searchButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
//                guard let coordinate = vc.locationManager.location?.coordinate else { return }
                let coordinate = vc.defaultCoordinate
                let nextVC = SearchViewController()
                // Test code 추후에 바꿔야함
                nextVC.viewModel.requsetSearchData(lat: coordinate.latitude, long: coordinate.longitude) { response in
                    switch response {
                    case .success(let success):
                        var fromQueueDBSet = Set<String>()
                        
                        success.fromQueueDB.map { $0.studylist }.forEach {
                            $0.forEach {
                                fromQueueDBSet.insert($0)
                            }
                        }
                        
                        success.fromQueueDBRequested.map { $0.studylist }.forEach {
                            $0.forEach {
                                fromQueueDBSet.insert($0)
                            }
                        }
                        
                        let fromQueueDBStudyTags = fromQueueDBSet.map { StudyTag(title: $0) }
                        let fromRecommendStudyTags = success.fromRecommend.map { StudyTag(title: $0) }
                        
                        nextVC.viewModel.lat = coordinate.latitude
                        nextVC.viewModel.long = coordinate.longitude
                        nextVC.viewModel.fromQueueDB.append(contentsOf: fromQueueDBStudyTags)
                        nextVC.viewModel.recommandData.append(contentsOf: fromRecommendStudyTags)
                        vc.transViewController(ViewController: nextVC, type: .push)
                    case .failure(let error):
                        print(error)
                        vc.view.makeToast("검색 에러가 발생하였습니다. \n잠시 후 다시 시도해주세요", position: .center)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}

extension HomeViewController {
    func checkUserDeviceLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        
        authorizationStatus = locationManager.authorizationStatus
        checkUserCurrentLocationAuthorization(authorizationStatus)
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOT DETERMINED")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("DENIED, 아이폰 설정으로 유도합니다.")
            setUserRegionAndAnnotation(lat: defaultCoordinate.latitude, long: defaultCoordinate.longitude)
        case .authorizedWhenInUse:
            print("WHEN IN USE")
//            locationManager.startUpdatingLocation()
            locationStatus = true
        default:
            print("DEFUALT")
        }
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.first {
            setUserRegionAndAnnotation(lat: coordinate.coordinate.latitude, long: coordinate.coordinate.longitude)
        }
        
//        locationManager.stopUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization()
    }
}

extension HomeViewController: MKMapViewDelegate {
    
}
