//
//  AroundSesacViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/21.
//

import UIKit

import RxCocoa
import RxSwift

class AroundSesacViewController: BaseViewController {
    let mainView = AroundSesacView()
    let disposeBag = DisposeBag()
    var hiddenFlag: [Bool] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureUI() {
        mainView.tableView.register(AroundSesacTableViewCell.self, forCellReuseIdentifier: AroundSesacTableViewCell.reuseIdentifier)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
}

extension AroundSesacViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        hiddenFlag.append(contentsOf: Array<Bool>(repeating: true, count: 3))
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AroundSesacTableViewCell.reuseIdentifier, for: indexPath) as? AroundSesacTableViewCell else { return UITableViewCell() }
        cell.cardView.nicknameView.moreButton.tag = indexPath.row
        cell.cardView.titleView.isHidden = hiddenFlag[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        hiddenFlag[indexPath.row].toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
