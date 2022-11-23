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
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    let locationManager = CLLocationManager()
    var locationStatus = false
    let defaultCoordinate = CLLocationCoordinate2D(latitude: 37.516857, longitude: 126.885798)
    var firstFlag = true
    
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
        //        setButtonStyle()
        searchData()
        requestMyQueueState()
    }
    
    private func requestMyQueueState() {
        viewModel.requsetMyStateData { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                dump(data)
                self.setButtonStyle(data.matched)
            case .failure(let error):
                switch MyQueueStateResponse(rawValue: error.rawValue) {
                case .normal:
                    self.setButtonStyle(error.rawValue)
                default:
                    print(error.rawValue, error)
                }
            }
        }
    }
    
    func setButtonStyle(_ matchState: Int) {
        switch matchState {
        case 201:
            mainView.searchButton.setImage(UIImage(named: HomeAssets.search.rawValue), for: .normal)
        case 0:
            mainView.searchButton.setImage(UIImage(named: HomeAssets.antenna.rawValue), for: .normal)
        case 1:
            mainView.searchButton.setImage(UIImage(named: HomeAssets.mail.rawValue), for: .normal)
        default:
            mainView.searchButton.setImage(UIImage(named: HomeAssets.search.rawValue), for: .normal)
        }
    }
    
    func searchData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self  else { return }
            let allAnotations = self.mainView.mapView.annotations
            self.mainView.mapView.removeAnnotations(allAnotations)
        }
        
        let center = mainView.mapView.region.center
        var gender = 0
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if self.mainView.manButton.backgroundColor == .sesacGreen {
                gender = 1
            } else if self.mainView.womanButton.backgroundColor == .sesacGreen {
                gender = 0
            } else {
                gender = 2
            }
        }
        
        viewModel.requsetSearchData(lat: center.latitude, long: center.longitude) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let success):
                if gender == 2 {
                    success.fromQueueDB.forEach { value in
                        let lat = Double(value.lat)
                        let long = Double(value.long)
                        self.setUserRegionAndAnnotation(lat: lat, long: long, sesac: value.sesac)
                    }
                    
                    success.fromQueueDBRequested.forEach { value in
                        let lat = Double(value.lat)
                        let long = Double(value.long)
                        self.setUserRegionAndAnnotation(lat: lat, long: long, sesac: value.sesac)
                    }
                } else {
                    success.fromQueueDB.filter { $0.gender == gender }.forEach { value in
                        let lat = Double(value.lat)
                        let long = Double(value.long)
                        self.setUserRegionAndAnnotation(lat: lat, long: long, sesac: value.sesac)
                    }
                    
                    success.fromQueueDBRequested.filter { $0.gender == gender }.forEach { value in
                        let lat = Double(value.lat)
                        let long = Double(value.long)
                        self.setUserRegionAndAnnotation(lat: lat, long: long, sesac: value.sesac)
                    }
                }
                
                dump(success)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setUserRegionAndAnnotation(lat: Double, long: Double, sesac: Int) {
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let annotation = CustomAnnotation(sesac_image: sesac, coordinate: location)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.mainView.mapView.addAnnotation(annotation)
        }
    }
    
    func setMyRegionAndAnnotation(lat: Double, long: Double) {
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 700, longitudinalMeters: 700)
        if firstFlag {
            mainView.mapView.setRegion(region, animated: false)
            firstFlag.toggle()
        }
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
                    //Test Code
//                    let location = CLLocationCoordinate2D(latitude: vc.defaultCoordinate.latitude, longitude: vc.defaultCoordinate.longitude)
//                    let region = MKCoordinateRegion(center: location, latitudinalMeters: 700, longitudinalMeters: 700)
//                    vc.mainView.mapView.setRegion(region, animated: true)
                    // Normal Code
                    vc.locationManager.startUpdatingLocation()
                    guard let coordinate = vc.locationManager.location?.coordinate else { return }
                    vc.firstFlag.toggle()
                    vc.setMyRegionAndAnnotation(lat: coordinate.latitude, long: coordinate.longitude)
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
                // Test Code: default -> vc.mainView.mapView.region.center로 바꿔야함
                let center = vc.defaultCoordinate // vc.mainView.mapView.region.center
                let nextVC = SearchViewController()
                // Test code 추후에 바꿔야함
                nextVC.viewModel.requsetSearchData(lat: center.latitude, long: center.longitude) { response in
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
                        
                        nextVC.viewModel.lat = center.latitude
                        nextVC.viewModel.long = center.longitude
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
        
        mainView.allButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.searchData()
            }
            .disposed(by: disposeBag)
        
        mainView.manButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.searchData()
            }
            .disposed(by: disposeBag)
        
        mainView.womanButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.searchData()
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
            setMyRegionAndAnnotation(lat: defaultCoordinate.latitude, long: defaultCoordinate.longitude)
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            locationManager.startUpdatingLocation()
            locationStatus = true
        default:
            print("DEFUALT")
        }
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.first {
            setMyRegionAndAnnotation(lat: coordinate.coordinate.latitude, long: coordinate.coordinate.longitude)
        }
        
        locationManager.stopUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization()
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if !animated {
            let lat = mapView.region.center.latitude
            let long = mapView.region.center.longitude
            
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                usleep(800000)
                if lat == mapView.region.center.latitude, long == mapView.region.center.longitude {
                    self.searchData()
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
            annotationView?.canShowCallout = false
            annotationView?.contentMode = .scaleAspectFit
        } else {
            annotationView?.annotation = annotation
        }
        
        let sesacImage: UIImage!
        let size = CGSize(width: 83, height: 83)
        UIGraphicsBeginImageContext(size)
        
        switch annotation.sesac_image {
        case 0:
            sesacImage = UIImage(named: SesacCharaterAssets.sesacFace1.rawValue)
        case 1:
            sesacImage = UIImage(named: SesacCharaterAssets.sesacFace2.rawValue)
        case 2:
            sesacImage = UIImage(named: SesacCharaterAssets.sesacFace3.rawValue)
        case 3:
            sesacImage = UIImage(named: SesacCharaterAssets.sesacFace4.rawValue)
        case 4:
            sesacImage = UIImage(named: SesacCharaterAssets.sesacFace5.rawValue)
        default:
            sesacImage = UIImage(named: SesacCharaterAssets.sesacFace1.rawValue)
        }
        
        sesacImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        annotationView?.image = resizedImage
        
        return annotationView
    }
}
