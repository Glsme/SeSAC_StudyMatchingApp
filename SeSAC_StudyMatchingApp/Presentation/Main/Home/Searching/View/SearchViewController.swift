//
//  SearchViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/16.
//

import UIKit
 
class SearchViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func configureUI() {
        setupSearchController()
    }
    
    func setupSearchController() {
        var screen = UIScreen.main.bounds
        var width = screen.width
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width - 20, height: 0))
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
}
