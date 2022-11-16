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
    let defaultCoordinate = CLLocationCoordinate2D(latitude: 37.517819364682694, longitude: 126.88647317074734)
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mainView.mapView.delegate = self
        checkUserDeviceLocationServiceAuthorization()
    }
    
    override func configureUI() {
        
    }
    
    func setUserRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 700, longitudinalMeters: 700)
        mainView.mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "현재 위치"
        
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
            print(coordinate.coordinate, "!!!!!!!!")
            setUserRegionAndAnnotation(center: coordinate.coordinate)
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
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return MKAnnotationView()
    }
}
